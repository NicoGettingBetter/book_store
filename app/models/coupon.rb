class Coupon < ApplicationRecord
  belongs_to :order

  validates_presence_of  :code, :sale

  scope :all_with_orders, -> { where(order_id: Order.all.map(&:id)) }

  def self.all_available
    Coupon.all - all_with_orders
  end
end
