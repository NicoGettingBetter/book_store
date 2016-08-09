module OrdersHelper
  def order_items
    presenter.order.order_items.decorate
  end
end
