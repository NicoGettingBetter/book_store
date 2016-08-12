class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user

  ratyrate_rateable 'rating'

  scope :approved_reviews, -> { where(approved: true) }

  def user
    Rate.user(id)
  end
end
