class OrdersPresenter < Rectify::Presenter
  attribute :orders

  delegate :in_queue, :in_delivery, :delivered, to: :orders, prefix: true

  def initialize user, *attrs
    super *attrs
    @orders = user.orders
  end

  def methods
    [:in_queue, :in_delivery, :delivered]
  end

  def order_in_progress_items
    @orders.in_progress.first.order_items.decorate
  end
end
