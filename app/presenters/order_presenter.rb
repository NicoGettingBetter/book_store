class OrderPresenter < Rectify::Presenter
  include Rails.application.routes.url_helpers

  attribute :order, Order
  attribute :billing_address, AddressForm
  attribute :shipping_address, AddressForm
  attribute :same_address, Object, default: false
  attribute :credit_card, CreditCardForm
  attribute :deliveries, Delivery

  delegate :coupon, :delivery, :order_items, to: :order

  def initialize *attrs
    super *attrs
    ['billing', 'shipping'].each do |type|
      send("#{type}_address=", AddressForm.from_model(order.send("#{type}_address") ||
        order.user.send("default_#{type}_address")))
    end
    @routes = { address: edit_address_order_path(id: order.id),
      payment: edit_payment_order_path(id: order.id),
      delivery: edit_delivery_order_path(id: order.id),
      confirm: edit_confirm_order_path(id: order.id),
      complete: complete_order_path(id: order.id) }
    @states = [ :address, :delivery, :payment, :confirm, :complete]
  end

  [:first_name, :last_name].each do |name|
    define_method name do |type|
      send(type).send(name) || order.user.send(name)
    end
  end

  [:street, :city, :zipcode, :phone, :country_id].each do |name|
    define_method name do |type|
      send(type).send(name)
    end
  end

  def header_before state
    safe_join(@states.split(state).first.map { |st| link_to t(st), @routes[st] }, ' '.html_safe)
  end

  def header_after state
    safe_join(@states.split(state).last.map do |st|
      CheckoutLink.call(order).linkable?(st) ? (link_to t(st), @routes[st]) : t(st)
    end, ' '.html_safe)
  end
end
