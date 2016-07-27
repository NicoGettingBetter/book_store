FactoryGirl.define do
  factory :book do 
    title FFaker::CheesyLingo.title
    short_description FFaker::CheesyLingo.paragraph(1)
    full_description FFaker::CheesyLingo.paragraph(1)
    image File.open "#{Rails.root}/app/assets/images/default.png"
    price 5
    instock 5
  end

  factory :out_of_stock_book, class: Book do
    title FFaker::CheesyLingo.title
    short_description FFaker::CheesyLingo.paragraph(1)
    full_description FFaker::CheesyLingo.paragraph(1)
    image File.open "#{Rails.root}/app/assets/images/default.png"
    price 5
    instock 0
  end
end