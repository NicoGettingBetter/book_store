class Order < ApplicationRecord
  include AASM

  aasm column: :state do
    state :in_progress, initial: true
    state :in_queue
    state :in_delivery
    state :delivered
    state :canceled

    event :place do
      transitions from: :in_progress, to: :in_queue
    end

    event :deliver do
      transitions from: :in_queue, to: :in_delivery
    end

    event :shipped do
      transitions from: :in_delivery, to: :delivered
    end

    event :cancel do
      transitions from: :in_queue, to: :canceled
    end
  end

  belongs_to :user
  has_one :credit_card
  has_one :coupon
  belongs_to :billing_address, class_name: 'Address'
  belongs_to :shipping_address, class_name: 'Address'
  has_many :order_items, dependent: :destroy
  belongs_to :delivery

  [:subtotal,
    :total,
    :sale,
    :delivery_price].each do |method|
      define_method(method) do
        OrderCalculator.call(self).public_send(method)
      end
    end

  def empty?
    order_items.empty?
  end
end
