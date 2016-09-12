class Rate < ActiveRecord::Base
  belongs_to :rater, class_name: "User"
  belongs_to :rateable, polymorphic: true

  scope :user, -> (id) { find_by(rateable_id: id).try(:rater) }
end
