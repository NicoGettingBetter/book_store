class Category < ApplicationRecord
	has_and_belongs_to_many :books

	validates :name, presence: true

  scope :has_books, -> { select{ |category| category.books.any? }}
end
