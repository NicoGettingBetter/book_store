module ApplicationHelper
  def price number
    number_to_currency number
  end

  def requires_field text
    "#{text}*"
  end

  def order_items_count
    count = current_order.order_items.try(:count)
    return t(:empty) if count == 0
    count
  end

  def cart_price
    return '' if order_items_count == t(:empty)
    price current_order.total
  end

  def cart
    " #{t(:cart)}:(#{order_items_count})#{cart_price}"
  end
end
