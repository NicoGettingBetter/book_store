class DeliveryForm < Rectify::Form 
  attribute :id, Fixnum

  validates_presence_of :id
  validate :inclusion

private
  def inclusion
    errors.add(:base, 'please choose delivery method') unless Delivery.all.map(&:id).include?(id)
  end
end