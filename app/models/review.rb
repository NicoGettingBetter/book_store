class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user

  ratyrate_rateable 'rating'

  scope :approved_reviews, -> (book) { where(approved: true, book: book) }

  def user
    Rate.user(self)
  end
end
