namespace :book_store do
  desc "delete empty orders"
  task delete_empty_orders: :environment do
    Order.delete Order.where(total_price: nil).where("updated_at < ?", (DateTime.now() - 7))
  end
end
