require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:book) { FactoryGirl.create(:book) }
  let(:book1) { FactoryGirl.create(:book) }
  let(:order) { FactoryGirl.create(:order, user: user) }
  let(:user) { FactoryGirl.create(:user) }
  let!(:order_item) { FactoryGirl.create(:order_item, valid_attributes) }
  let(:valid_attributes) {
    {
      book_id: book.id,
      order_id: order.id,
      quantity: 2
    }
  }
  let(:valid1_attributes) {
    {
      book_id: book1.id,
      order_id: order.id,
      quantity: 2
    }
  }

  let(:valid_session) { {} }

  describe "POST create" do
    describe "with valid params" do
      before do
        @request.env['HTTP_REFERER'] = "http://localhost:3000/book/#{book.id}"
        allow(request.env['warden']).to receive(:authenticate!).and_return(user)
        allow(controller).to receive(:current_user).and_return(user)
        allow(controller).to receive(:current_order).and_return(order)
      end

      it "creates a new OrderItem" do
        expect {
          process :create, method: :post, params: {order_item: valid1_attributes}
        }.to change(OrderItem, :count).by(1)
      end

      it "doesn't create a new OrderItem" do
        expect {
          process :create, method: :post, params: {order_item: valid_attributes}
        }.to change(OrderItem, :count).by(0)
      end
    end
  end

  describe "DELETE destroy" do
    before do
      @request.env['HTTP_REFERER'] = "http://test.host/orders/#{order.id}/edit"
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
      allow(controller).to receive(:current_order).and_return(order)
    end

    it "destroys the requested order item" do
      expect {
        process :destroy, method: :delete, params: { id: order_item.id }
      }.to change(OrderItem, :count).by(-1)
    end
  end
end
