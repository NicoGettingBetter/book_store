class UpdateOrderItem < BaseCommand
  def name
    :update_order_item
  end

  private
    def update_order_item
      order_item.update(quantity: @form.quantity)
    end

    def order_item
      OrderItem.find(@form.id)
    end
end