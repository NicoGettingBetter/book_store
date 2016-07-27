class OrderItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order_item, only: [:destroy]

  def create
    create_or_update
  end

  def update
    create_or_update
  end

  def destroy
    @order_item.destroy
    respond_to do |format|
      format.html { redirect_to :back }
    end
  end

  private

    def create_or_update
      @form = OrderItemForm.from_params(order_item_params, order_id: current_order.id)
      
      SetOrUpdateOrderItem.call(@form) do 
        on(:ok) { redirect_to :back }
      end
    end

    def set_order_item
      @order_item = OrderItem.find(params[:id])
    end

    def order_item_params
      params.require(:order_item).permit(:book_id, :quantity, :price)
    end
end