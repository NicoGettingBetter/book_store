FactoryGirl.define do 
  factory :order, class: Order do
    state 'in progress'
  end

  factory :order_in_progress, class: Order do
    state 'in progress'
  end

  factory :order_in_queue, class: Order do
    state 'in queue'
  end

  factory :order_in_delivery, class: Order do
    state 'in delivery'
  end

  factory :order_delivered, class: Order do
    state 'delivered'
  end
end