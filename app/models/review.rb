class Review < ApplicationRecord
	belongs_to :user
	belongs_to :book

  ratyrate_rateable 'rating'
  
  scope :approved_reviews, -> (book) { where(approved: true, book: book) }
end