class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :book

  scope :if_exist, -> (order, book) { where(order: order, book: book) }

  def self.exist_or_new order, book
    if_exist(order, book).first || OrderItem.new(quantity: 1)
  end
end
