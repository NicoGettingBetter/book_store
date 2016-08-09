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

  #scope :in_progress, -> (user) { where(state: :in_progress, user: user) }
  #scope :in_queue, -> (user) { where(state: :in_queue, user: user) }
  #scope :in_delivery, -> (user) { where(state: :in_delivery, user: user) }
  #scope :delivered, -> (user) { where(state: :delivered, user: user) }

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
