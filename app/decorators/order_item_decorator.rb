class OrderItemDecorator < BaseDecorator
  delegate_all

  def total
    object.quantity * object.price
  end
end
