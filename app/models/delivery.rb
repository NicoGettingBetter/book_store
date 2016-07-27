class Delivery < ApplicationRecord
  has_many :orders

  validates_presence_of :company,
                        :delivery_method,
                        :price
end
