module OrdersHelper
  def methods
    [:in_queue, :in_delivery, :delivered]
  end

  def order_in_progress_items current_user
    Order.in_progress(current_user).first.order_items.map(&:decorate)
  end

  def orders_in_queue current_user
    Order.in_queue(current_user)
  end

  def orders_in_delivery current_user
    Order.in_delivery(current_user)
  end

  def orders_delivered current_user
    Order.delivered(current_user)
  end

  def order_items
    presenter.order.order_items.map(&:decorate)
  end
end
