FactoryGirl.define do 
  factory :coupon do 
    code '111111'
    sale 20
  end

  factory :coupon_empty, class: Coupon do 
    code ''
  end
end