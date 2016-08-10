class UpdateOrder < Rectify::Command
  def initialize form, names
    @form = form
    @names = names
    @names = [names] if names.class == Symbol
  end

  def call
    return broadcast(:invalid) if @form.invalid?

    transaction do
      @names.each do |name|
        send "set_or_update_#{name}"
      end
    end

    broadcast(:ok)
  end

  private
    def set_or_update_order_items
      order_items.keys.each do |id|
        order_item = order_item id
        if order_item_params(id)['quantity'].to_i > order_item.book.instock
          order_item.update(quantity: order_item.book.instock)
        elsif order_item_params(id)['quantity'].to_i < 1
          order_item.update(quantity: 1)
        else
          order_item.update(order_item_params(id))
        end
      end if order_items
    end

    def order_items
      @form.order_items
    end

    def order_item_params id
      order_items.require(id).permit('quantity')
    end

    def order_item id
      OrderItem.find(id.to_i)
    end

    def set_or_update_coupon
      current_order.update(coupon: Coupon.find_by(code: coupon))
    end

    def coupon
      @form.coupon
    end

    def set_or_update_addresses
      billing_address = @form.billing_address.id == '' ? create_address(:billing_address) :
        update_address(:billing_address)
      shipping_address = if @form.same_address
        create_address(:billing_address)
      else
        @form.shipping_address.id == '' ? create_address(:shipping_address) :
          update_address(:shipping_address)
      end
      update_order(billing_address: billing_address, shipping_address: shipping_address)
    end

    def update_order *attrs
      current_order.update(*attrs)
    end

    def create_address type
      Address.create(address_params(type))
    end

    def update_address type
      address = Address.find(@form.send(type).id)
      address.update(address_params(type))
      address
    end

    def address_params type
      @form.send(type).attributes.without(:type, :id)
    end

    def set_or_update_delivery
      update_order(delivery: Delivery.find(@form.delivery.id))
    end

    def set_or_update_credit_card
      update_order(credit_card: create_credit_card)
    end

    def create_credit_card
      CreditCard.create(@form.credit_card.attributes)
    end

    def set_or_update_order
      order = current_order
      order.order_items.each do |order_item|
        order_item.quantity = order_item.book.instock if order_item.book.instock < order_item.quantity
        order_item.book.sold_books order_item.quantity
      end
      order.place if order.may_place?
      order.update(total_price: order.total, completed_date: Time.now)
    end
end
