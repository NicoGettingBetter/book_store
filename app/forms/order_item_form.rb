class OrderItemForm < Rectify::Form
  attribute :price, Float
  attribute :quantity, Integer
  attribute :order_id, Integer
  attribute :book_id, Integer

  validates :price,
            :quantity,
            :order_id,
            :book_id,
            presence: true
  validates :price,
            :quantity,
            numericality: {grater_then: 0 }
end