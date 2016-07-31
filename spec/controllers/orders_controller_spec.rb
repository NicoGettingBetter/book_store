require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:book) { FactoryGirl.create(:book) }
  let!(:order) { FactoryGirl.create(:order, user: user) }
  let!(:order_item) { FactoryGirl.create(:order_item, order: order, book: book) }
  let(:user) { FactoryGirl.create(:user) }
  let!(:coupon) { FactoryGirl.create(:coupon) }
  let(:valid_objects) {
    {
      billing_address: FactoryGirl.create(:address),
      shipping_address: FactoryGirl.create(:address),
      coupon: FactoryGirl.create(:coupon),
      credit_card: FactoryGirl.create(:credit_card),
      delivery: FactoryGirl.create(:delivery)
    }
  }
  let(:valid_attributes) {
    {
      billing_address: FactoryGirl.attributes_for(:address),
      shipping_address: FactoryGirl.attributes_for(:address),
      coupon: FactoryGirl.attributes_for(:coupon),
      credit_card: FactoryGirl.attributes_for(:credit_card),
      delivery: FactoryGirl.attributes_for(:delivery)
    }
  }

  let(:invalid_attributes) {
    {
      billing_address: FactoryGirl.attributes_for(:address_empty),
      shipping_address: FactoryGirl.attributes_for(:address_empty),
      coupon: FactoryGirl.attributes_for(:coupon_empty, code: '111'),
      credit_card: FactoryGirl.attributes_for(:credit_card_empty),
      delivery: { id: '' }
    }
  }

  let(:valid_session) { {} }
  let(:order_in_queue) { FactoryGier.create(:order_in_queue, user: user) }

  describe 'GET index' do
    before do
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
      allow(controller).to receive(:current_order).and_return(order)
      order.update(valid_objects)
    end
    
    it 'render index template' do 
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET show' do
    before do
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
      allow(controller).to receive(:current_order).and_return(order)
    end

    it 'render show template' do 
      get :show, { id: order.id }
      expect(response).to render_template :show
    end
  end

  describe "GET edit" do
    before do
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
      allow(controller).to receive(:current_order).and_return(order)
    end

    it "render edit template" do
      get :edit, {id: order.id }
      expect(response).to render_template :edit
    end
  end

  describe "PUT update" do
    before do
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
      allow(controller).to receive(:current_order).and_return(order)
      order.update(valid_objects)
    end

    describe "with valid params" do
      let(:new_attributes) {
        {
          order_items: { order_item.id.to_s => { quantity: '5' } }, 
          coupon: coupon.code
        }
      }

      it "updates the requested order" do
        put :update, {id: order.to_param, order: new_attributes}
        order.reload
        expect(order.order_items.first.quantity).to eq(5)
        expect(order.coupon).not_to be_nil 
      end
    end

    describe "with invalid params" do
      it "re-renders the 'edit' template" do
        put :update, {id: order.to_param, order: { coupon: '111' } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE destroy" do
    before do
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
      allow(controller).to receive(:current_order).and_return(order)
      order.update(valid_objects)
    end

    it "destroys the requested order" do
      expect {
        delete :destroy, {id: order.id }
      }.to change(Order, :count).by(-1)
    end

    it "redirects to empty cart" do
      delete :destroy, {id: order.id }
      expect(response).to redirect_to edit_order_url
    end
  end

  describe 'GET edit_address' do
    before do
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
      allow(controller).to receive(:current_order).and_return(order)
    end

    it "render edit_address template" do
      get :edit_address, {id: order.id }
      expect(response).to render_template 'orders/edit_address'
    end
  end

  describe 'PUT address' do 
    before do
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
      allow(controller).to receive(:current_order).and_return(order)
    end

    describe "with valid params" do
      let(:new_attributes) {
        {
          billing_address: FactoryGirl.attributes_for(:address, first_name: 'billing_updated', id: ''), 
          shipping_address: FactoryGirl.attributes_for(:address, first_name: 'shipping_updated', id: ''),
          use_billing_address: { check: '0'}
        }
      }

      let(:new1_attributes) {
        {
          billing_address: FactoryGirl.attributes_for(:address, first_name: 'updated', id: ''), 
          shipping_address: FactoryGirl.attributes_for(:address_empty),
          use_billing_address: { check: '1'}
        }
      }

      it "updates the requested order with different addresses" do
        put :order_address, {id: order.to_param}.merge(new_attributes)
        order.reload
        expect(order.billing_address.first_name).to eq('billing_updated')
        expect(order.shipping_address.first_name).to eq('shipping_updated')
      end

      it "updates the requested order with same addresses" do
        put :order_address, {id: order.to_param}.merge(new1_attributes)
        order.reload
        expect(order.billing_address.first_name).to eq('updated')
        expect(order.shipping_address.first_name).to eq('updated')
      end

      it 'redirects to delivery' do 
        put :order_address, {id: order.to_param}.merge(new_attributes)
        expect(request).to redirect_to(delivery_order_path)
      end
    end

    describe "with invalid params" do
      it "re-renders the 'edit_address' template" do
        put :order_address, {id: order.to_param}.merge(invalid_attributes.slice(:billing_address,
          :shipping_address)).merge(use_billing_address: {check: '1'})
        expect(response).to render_template('orders/edit_address')
      end
    end
  end

  describe 'GET edit_delivery' do
    before do
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
      allow(controller).to receive(:current_order).and_return(order)
    end

    it "render edit_delivery template" do
      get :edit_delivery, {id: order.id }
      expect(response).to render_template 'orders/edit_delivery'
    end
  end

  describe 'PUT delivery' do 
    before do
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
      allow(controller).to receive(:current_order).and_return(order)
    end

    describe "with valid params" do
      let(:delivery) { FactoryGirl.create(:delivery) }
      let(:new_attributes) {
        {
          order: { shipping: delivery.id.to_s }
        }
      }

      it "updates the requested order with delivery" do
        put :order_delivery, {id: order.to_param}.merge(new_attributes)
        order.reload
        expect(order.delivery).not_to be_nil
      end

      it 'redirects to payment' do 
        put :order_delivery, {id: order.to_param}.merge(new_attributes)
        expect(request).to redirect_to(payment_order_path)
      end
    end

    describe "with invalid params" do
      let(:new_attributes) {
        {
          order: { shipping: '' }
        }
      }

      it "re-renders the 'edit_delivery' template" do
        put :order_delivery, {id: order.to_param}.merge(new_attributes)
        expect(response).to render_template('orders/edit_delivery')
      end
    end
  end

  describe 'GET edit_payment' do
    before do
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
      allow(controller).to receive(:current_order).and_return(order)
    end

    it "render edit_payment template" do
      get :edit_payment, {id: order.id }
      expect(response).to render_template 'orders/edit_payment'
    end
  end

  describe 'PUT payment' do 
    before do
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
      allow(controller).to receive(:current_order).and_return(order)
    end

    describe "with valid params" do
      let(:new_attributes) {
        {
          credit_card: FactoryGirl.attributes_for(:credit_card)
        }
      }

      it "updates the requested order with payment" do
        put :order_payment, {id: order.to_param}.merge(new_attributes)
        order.reload
        expect(order.credit_card).not_to be_nil
      end

      it 'redirects to confirm' do 
        put :order_payment, {id: order.to_param}.merge(new_attributes)
        expect(request).to redirect_to(confirm_order_path)
      end
    end

    describe "with invalid params" do
      let(:new_attributes) {
        {
          credit_card: FactoryGirl.attributes_for(:credit_card_empty)
        }
      }

      it "re-renders the 'edit_payment' template" do
        put :order_payment, {id: order.to_param}.merge(new_attributes)
        expect(response).to render_template('orders/edit_payment')
      end
    end
  end

  describe 'GET edit_confirm' do
    before do
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
      allow(controller).to receive(:current_order).and_return(order)
    end

    it "render edit_confirm template" do
      get :edit_confirm, {id: order.id }
      expect(response).to render_template 'orders/edit_confirm'
    end
  end

  describe 'PUT confirm' do 
    before do
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
      allow(controller).to receive(:current_order).and_return(order)
    end

    describe "no params" do
      it "set the requested order state to 'in_queue'" do
        put :order_confirm, {id: order.to_param}
        order.reload
        expect(order.state).to eq('in_queue')
      end

      it "set the requested order price" do
        put :order_confirm, {id: order.to_param}
        order.reload
        expect(order.total_price).not_to be_nil
      end

      it 'redirects to complete' do 
        put :order_confirm, {id: order.to_param}
        expect(request).to redirect_to(complete_order_path)
      end
    end
  end

  describe 'GET complete' do 
    before do
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
      allow(controller).to receive(:current_order).and_return(order)
    end

    it "render edit_confirm template" do
      get :complete, {id: order.id }
      expect(response).to render_template 'orders/complete'
    end
  end
end