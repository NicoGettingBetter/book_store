require 'rails_helper'

RSpec.describe OrdersController, :type => :controller do

  let(:order) { FactoryGirl.create(:order) }
  let(:valid_attributes) {
    {
      billing_address: {

        },
      shipping_address: {

        },
      coupon: {

        },
      credit_card: {

      }
    }
  }

  let(:invalid_attributes) {
  }

  let(:valid_session) { {} }
  let(:order_in_queue) { FactoryGier.create(:order_in_queue) }

  describe "GET edit" do
    it "render edit template" do
      order = FactoryGirl.create(:order)
      get :edit, {id: order.id }
      expect(response).to render_template :edit
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested order" do
        order = Order.create! valid_attributes
        put :update, {id: order.to_param, :order => new_attributes}, valid_session
        order.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested order as @order" do
        order = Order.create! valid_attributes
        put :update, {id: order.to_param, :order => valid_attributes}, valid_session
        expect(assigns(:order)).to eq(order)
      end

      it "redirects to the order" do
        order = Order.create! valid_attributes
        put :update, {id: order.to_param, :order => valid_attributes}, valid_session
        expect(response).to redirect_to(order)
      end
    end

    describe "with invalid params" do
      it "assigns the order as @order" do
        order = Order.create! valid_attributes
        put :update, {id: order.to_param, :order => invalid_attributes}, valid_session
        expect(assigns(:order)).to eq(order)
      end

      it "re-renders the 'edit' template" do
        order = Order.create! valid_attributes
        put :update, {id: order.to_param, :order => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested order" do
      order = Order.create! valid_attributes
      expect {
        delete :destroy, {id: order.id }
      }.to change(Order, :count).by(-1)
    end

    it "redirects to empty cart" do
      order = Order.create! valid_attributes
      delete :destroy, {id: order.id }
      expect(response).to redirect_to :edit
    end
  end

end
