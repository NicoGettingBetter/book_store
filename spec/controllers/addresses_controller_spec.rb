require 'rails_helper'

RSpec.describe AddressesController, :type => :controller do
  let(:valid_attributes) {
    { first_name: FFaker::Name.first_name,
      last_name: FFaker::Name.last_name,
      street: FFaker::Address.street_address,
      zipcode: 1,
      city: FFaker::Address.city,
      phone: FFaker::PhoneNumberAU.international_phone_number,
      country_id: 1,
      type: :default_billing_address }
  }

  let(:invalid_attributes) {
    { first_name: '',
      last_name: '',
      street: '',
      zipcode: '',
      city: '',
      phone: '111',
      country_id: '',
      type: :default_billing_address }
  }

  let(:user) { FactoryGirl.create(:user) }

  before do
    allow(controller).to receive(:current_user) { user }
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Address" do
        expect {
          post :create, {address: valid_attributes}
        }.to change(Address, :count).by(1)
      end

      it "assigns a newly created address form as @form" do
        post :create, {address: valid_attributes}
        expect(assigns(:form)).to be_a(AddressForm)
      end

      it "redirects to the settings" do
        post :create, {address: valid_attributes}
        expect(response).to redirect_to(settings_path)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved form address" do
        post :create, {address: invalid_attributes}
        expect(assigns(:form)).to be_a(AddressForm)
      end

      it "re-renders the 'settings' template" do
        post :create, {address: invalid_attributes}
        expect(response).to render_template('settings/index')
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        { first_name: 'New name',
          last_name: FFaker::Name.last_name,
          street: FFaker::Address.street_address,
          zipcode: 1,
          city: FFaker::Address.city,
          phone: FFaker::PhoneNumberAU.international_phone_number,
          country_id: 1,
          type: :default_billing_address }
      }

      it "updates the requested address", :focus do
        address = Address.create! valid_attributes.without(:type)
        put :update, {id: 'address', format: address.id, address: new_attributes }
        address.reload
        expect(Address.find(address.id).first_name).to eq 'New name'
      end

      it "redirects to the settings" do
        address = Address.create! valid_attributes.without(:type)
        put :update, {id: 'address', format: address.id, address: valid_attributes}
        expect(response).to redirect_to(settings_path)
      end
    end

    describe "with invalid params" do
      it "assigns the address as @address" do
        address = Address.create! valid_attributes.without(:type)
        put :update, {id: address.id, address: invalid_attributes}
        expect(Address.find(address.id)).to eq(address)
      end

      it "re-renders the 'settings' template" do
        address = Address.create! valid_attributes.without(:type)
        put :update, {id: address.id, address: invalid_attributes}
        expect(response).to render_template("settings/index")
      end
    end
  end
end
