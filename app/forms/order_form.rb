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

  def from_addresses options
    @billing_address = AddressForm.from_params(options[:billing_address], type: :billing_address)
    @same_address = options[:check]
    unless @same_address
      @shipping_address = AddressForm.from_params(options[:shipping_address], type: :shipping_address)
    end
  end

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
