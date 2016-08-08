FactoryGirl.define do
  factory :credit_card do 
    number '1111111111111111'
    cvv '111'
    expiration_month Date::MONTHNAMES.drop(1).sample
    expiration_year '2018'
  end

  factory :credit_card_empty, class: CreditCard do 
    number ''
    cvv ''
    expiration_month ''
    expiration_year ''
  end
end