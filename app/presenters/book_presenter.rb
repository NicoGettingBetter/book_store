class BookPresenter < Rectify::Presenter
  attribute :book, Book
  attribute :order_item, OrderItem

  def approved_reviews
    book.reviews.approved_reviews
  end

  def description
    book.full_description.truncate(2000)
  end
end
