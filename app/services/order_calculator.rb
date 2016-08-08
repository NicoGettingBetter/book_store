class OrderCalculator
  def self.call order
    self.new order
  end

  delegate :order_items, :coupon, :delivery, to: :order

  def subtotal
    sum - sale
  end

  def total
    subtotal + delivery_price
  end

  def sale
    return 0 unless coupon
    sum * coupon.sale / 100 
  end

  def delivery_price
    return 0 unless delivery
    delivery.price
  end

  private 
    def initialize order
      @order = order
    end

    def sum
      order_items.map{ |order_item| order_item.price * order_item.quantity }.sum
    end

    attr_reader :order
end