class OrderItemForm < Rectify::Form
  attribute :price, Float
  attribute :quantity, Integer
  attribute :order_id, Integer
  attribute :book_id, Integer
  attribute :id, Integer

  validates :quantity,
            :order_id,
            :book_id,
            presence: true
  validates :quantity,
            numericality: { grater_then: 0 }

  def set_price
    @price = Book.find(book_id).price
  end
end