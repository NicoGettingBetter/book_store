class OrderForm < Rectify::Form
  attribute :order_items, OrderItem
  attribute :billing_address, AddressForm
  attribute :shipping_address, AddressForm
  attribute :same_address, Object
  attribute :credit_card, CreditCardForm
  attribute :coupon, Coupon
  attribute :delivery, Delivery

  validates_length_of :coupon, is: 6, allow_blank: true
  validates :coupon, 
    inclusion: { in: Coupon.all.map(&:code) << '' << nil, 
    message: 'not available' }
  validates :delivery, inclusion: { in: Delivery.all.to_a << nil }

  def invalid?
    !valid?
  end

  def valid?
    output = super
    if shipping_address
      shipping_address.valid?
      billing_address.valid? &&
        shipping_address.valid? &&
        errors.empty? && output
    elsif billing_address
      billing_address.valid? &&
        errors.empty? && output
    elsif credit_card
      credit_card.valid? &&
        errors.empty? && output
    else
      errors.empty? && output
    end
  end
end