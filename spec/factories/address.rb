FactoryGirl.define do
  factory :address do
    first_name FFaker::Name.first_name
    last_name FFaker::Name.last_name
    street FFaker::Address.street_address
    zipcode 1
    city FFaker::Address.city
    phone FFaker::PhoneNumberAU.international_phone_number
    country_id 1
  end
end
