class OrderForm < Rectify::Form
  attribute :order_items, OrderItem
  attribute :billing_address, AddressForm
  attribute :shipping_address, AddressForm
  attribute :same_address, Object
  attribute :credit_card, CreditCardForm
  attribute :coupon, Coupon
  attribute :delivery, DeliveryForm

  validates_length_of :coupon, is: 6, allow_blank: true
  validates :coupon,
    inclusion: { in: Coupon.all_available.map(&:code) << '' << nil,
    message: 'not available' }

  def invalid?
    !valid?
  end

  def valid?
    if shipping_address
      addresses_valid?
    elsif billing_address
      billing_address.valid?
    elsif credit_card
      credit_card.valid?
    elsif delivery
      delivery.valid?
    else
      super
    end
  end

  private

    def addresses_valid?
      billing_address.valid? & shipping_address.valid?
    end
end
