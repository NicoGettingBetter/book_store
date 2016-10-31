class ReviewForm < Rectify::Form
  attribute :id, Integer
  attribute :text, String

  validates_presence_of :text, :id
  validate :has_rating

  private
    def has_rating
      errors.add(:base, 'Comment must have a rating') unless Rate.find_by(rateable_id: id)
    end
end
