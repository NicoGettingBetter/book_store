class Category < ApplicationRecord
  has_and_belongs_to_many :books

  validates_presence_of :name

  scope :has_books, -> { select{ |category| category.books.any? }}
end
