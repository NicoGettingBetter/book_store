class SetOrUpdateOrderItem < BaseCommand
  def name
    :set_or_update_order_item
  end

  private

    def set_or_update_order_item
      if order_items.any?
        @form.quantity += order_item.quantity
        @form.quantity = book_instock if book_instock < @form.quantity
        order_item.update(quantity: @form.quantity)
      else
        OrderItem.create(attributes)
      end
    end

    def order_items
      order.order_items.select{ |order_item| order_item.book_id == book_id }
    end

    def order_item
      order_items.first
    end

    def order
      Order.find @form.order_id
    end

    def attributes
      @form.attributes
    end

    def book_id
      @form.book_id
    end

    def book_instock
      Book.find(book_id).instock
    end
end