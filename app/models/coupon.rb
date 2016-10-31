class Coupon < ApplicationRecord
  belongs_to :order

  validates_presence_of :code, :sale

  scope :all_with_orders, -> { where.not(order_id: nil) }

  def self.all_available
    all - all_with_orders
  end
end
