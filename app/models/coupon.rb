class Coupon < ApplicationRecord
  belongs_to :order

  validates_presence_of  :code,
                        :sale
end
