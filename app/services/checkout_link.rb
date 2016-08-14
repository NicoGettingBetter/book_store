class CheckoutLink
  def self.call order
    self.new order
  end

  delegate :order_items, :coupon, :delivery, to: :order

  @states = [ :address, :delivery, :payment, :confirm, :complete]

  def linkable? state
    case state
    when :address
      true
    when :delivery
      @order.billing_address && @order.shipping_address
    when :payment
      @order.delivery
    when :confirm
      @order.credit_card
    when :complete
      false
    else
      raise 'No state error'
    end
  end

  private
    def initialize order
      @order = order
    end

    attr_reader :order
end
