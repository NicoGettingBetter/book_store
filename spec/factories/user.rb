FactoryGirl.define do 
  factory :user do 
    email FFaker::Internet.email
    password '123456'
    first_name FFaker::Name.first_name
    last_name FFaker::Name.last_name
  end

  factory :test_user, class: User do
    email 'test@test.test'
    password '123456'
    first_name 'Test'
    last_name 'Test'
  end

  factory :admin, class: User do
    email 'admin@admin.admin'
    password '123456'
    first_name 'Admin'
    last_name 'Admin'
    admin true
  end
end