FactoryGirl.define do 
  factory :order, class: Order do
    state :in_progress
  end

  factory :order_in_progress, class: Order do
    state :in_progress
  end

  factory :order_in_queue, class: Order do
    state :in_queue
  end

  factory :order_in_delivery, class: Order do
    state :in_delivery
  end

  factory :order_delivered, class: Order do
    state :delivered
  end

  factory :order_presenter do
  end
end