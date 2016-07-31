class Rate < ActiveRecord::Base
  belongs_to :rater, :class_name => "User"
  belongs_to :rateable, :polymorphic => true

  scope :user, -> (rateable) { Rate.find_by(rateable: rateable).rater }

  #attr_accessible :rate, :dimension

end