FactoryGirl.define do
  factory :author do
    first_name FFaker::Name.first_name
    last_name FFaker::Name.last_name
    description FFaker::CheesyLingo.paragraph(1)
  end
end
