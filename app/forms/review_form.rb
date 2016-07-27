class ReviewForm < Rectify::Form
  attribute :id, Integer
  attribute :text, String
  attribute :user, User
  attribute :book, Book

  validates_presence_of :text, :book, :id
end