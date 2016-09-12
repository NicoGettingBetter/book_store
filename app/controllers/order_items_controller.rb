class OrderItemsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_order_item, only: [:destroy]

  def create
    @form = OrderItemForm.from_params(order_item_params, order_id: current_order.id)
    @form.set_price

    SetOrUpdateOrderItem.call(@form) do
      on(:ok) { redirect_back(fallback_location: root_path) }
    end
  end

  def destroy
    @order_item.delete
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
    end
  end

  private
    def set_order_item
      @order_item = OrderItem.find(params[:id])
    end

    def order_item_params
      params.require(:order_item).permit(:book_id, :quantity)
    end
end
