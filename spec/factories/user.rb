FactoryGirl.define do 
  factory :user do 
    sequence(:email) { |n| "test#{n}@example.com" }
    password '123456'
    first_name FFaker::Name.first_name
    last_name FFaker::Name.last_name
  end

  factory :admin, class: User do
    sequence(:email) { |n| "admin#{n}@example.com" }
    password '123456'
    first_name 'Admin'
    last_name 'Admin'
    admin true
  end
end