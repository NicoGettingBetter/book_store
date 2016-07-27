# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

countries = ISO3166::Country.all_translated.map do |country|
    { country => Country.create(name: country) }
  end.reduce(:merge)

Delivery.create([{ company: 'Ukrpost', delivery_method: 'Ground', price: 1 },
{ company: 'New post', delivery_method: 'Ground', price: 1.5 },
{ company: 'New post', delivery_method: 'Air', price: 5 }])

10.times do
  User.create(first_name: FFaker::Name.first_name,
              last_name: FFaker::Name.last_name,
              email: FFaker::Internet.email,
              password: '123456')
end

categories = [
  'Web development', 
  'Fantasy',
  'Cookbooks',
  'Horror',
  'Dictionnaries',
  'Drama'].map do |name|
    { name => Category.create(name: name) }
  end.reduce(:merge)

25.times do 
  Author.create(
  first_name: FFaker::Name.first_name,
  last_name: FFaker::Name.last_name,
  description: FFaker::CheesyLingo.paragraph(rand(30..40)))
end

books = [
  {title: 'JavaScript&jQuery', image: File.open("#{Rails.root}/app/assets/images/javascript_jquery.png"), categories: [categories['Web development']]},
  {title: 'IT', image: File.open("#{Rails.root}/app/assets/images/it.png"), categories: [categories['Web development'], categories['Horror']]},
  {title: 'Flowers for Algernon', image: File.open("#{Rails.root}/app/assets/images/algernon_flowers.jpg"), categories:  [categories['Fantasy']]},
  {title: 'Cujo', image: File.open("#{Rails.root}/app/assets/images/cujo.jpeg"), categories: [categories['Drama'], categories['Horror']]},
  {title: 'Desperation', image: File.open("#{Rails.root}/app/assets/images/desperation.jpg"), categories: [categories['Horror']]},
  {title: 'Fahrenheit 451', image: File.open("#{Rails.root}/app/assets/images/fahrenheit451.jpg"), categories: [categories['Drama'], categories['Horror']]},
  {title: 'Revival', image: File.open("#{Rails.root}/app/assets/images/revival.jpg"), categories: [categories['Cookbooks'], categories['Horror']]},
  {title: 'Something Wicked', image: File.open("#{Rails.root}/app/assets/images/something_wicked.jpeg"), categories: [categories['Fantasy'], categories['Horror']]},
  {title: 'Enterprise web development', image: File.open("#{Rails.root}/app/assets/images/web_dev.png"), categories: [categories['Web development']]},
  {title: 'The truth about html5', image: File.open("#{Rails.root}/app/assets/images/web_development.jpg"), categories: [categories['Web development'], categories['Horror']]},
  {title: 'Easy baking', image: File.open("#{Rails.root}/app/assets/images/easy_baking.jpg"), categories: [categories['Cookbooks']]},
  {title: 'Cookbook', image: File.open("#{Rails.root}/app/assets/images/cookbook.jpg"), categories: [categories['Cookbooks']]},
  {title: 'Vegetarian cookbook', image: File.open("#{Rails.root}/app/assets/images/vegetarian_cookbook.jpg"), categories: [categories['Web development'], categories['Horror']]},
  {title: 'JavaScript&jQuery', image: File.open("#{Rails.root}/app/assets/images/javascript_jquery.png"), categories: [categories['Web development']]},
  {title: 'IT', image: File.open("#{Rails.root}/app/assets/images/it.png"), categories: [categories['Web development'], categories['Horror']]},
  {title: 'Flowers for Algernon', image: File.open("#{Rails.root}/app/assets/images/algernon_flowers.jpg"), categories:  [categories['Fantasy']]},
  {title: 'Cujo', image: File.open("#{Rails.root}/app/assets/images/cujo.jpeg"), categories: [categories['Drama'], categories['Horror']]},
  {title: 'Desperation', image: File.open("#{Rails.root}/app/assets/images/desperation.jpg"), categories: [categories['Horror']]},
  {title: 'Fahrenheit 451', image: File.open("#{Rails.root}/app/assets/images/fahrenheit451.jpg"), categories: [categories['Drama'], categories['Horror']]},
  {title: 'Revival', image: File.open("#{Rails.root}/app/assets/images/revival.jpg"), categories: [categories['Cookbooks'], categories['Horror']]},
  {title: 'Something Wicked', image: File.open("#{Rails.root}/app/assets/images/something_wicked.jpeg"), categories: [categories['Fantasy'], categories['Horror']]},
  {title: 'Enterprise web development', image: File.open("#{Rails.root}/app/assets/images/web_dev.png"), categories: [categories['Web development']]},
  {title: 'The truth about html5', image: File.open("#{Rails.root}/app/assets/images/web_development.jpg"), categories: [categories['Web development'], categories['Horror']]},
  {title: 'Easy baking', image: File.open("#{Rails.root}/app/assets/images/easy_baking.jpg"), categories: [categories['Cookbooks']]},
  {title: 'Cookbook', image: File.open("#{Rails.root}/app/assets/images/cookbook.jpg"), categories: [categories['Cookbooks']]},
  {title: 'Vegetarian cookbook', image: File.open("#{Rails.root}/app/assets/images/vegetarian_cookbook.jpg"), categories: [categories['Web development'], categories['Horror']]},
  {title: 'JavaScript&jQuery', image: File.open("#{Rails.root}/app/assets/images/javascript_jquery.png"), categories: [categories['Web development']]},
  {title: 'IT', image: File.open("#{Rails.root}/app/assets/images/it.png"), categories: [categories['Web development'], categories['Horror']]},
  {title: 'Flowers for Algernon', image: File.open("#{Rails.root}/app/assets/images/algernon_flowers.jpg"), categories:  [categories['Fantasy']]},
  {title: 'Cujo', image: File.open("#{Rails.root}/app/assets/images/cujo.jpeg"), categories: [categories['Drama'], categories['Horror']]},
  {title: 'Desperation', image: File.open("#{Rails.root}/app/assets/images/desperation.jpg"), categories: [categories['Horror']]},
  {title: 'Fahrenheit 451', image: File.open("#{Rails.root}/app/assets/images/fahrenheit451.jpg"), categories: [categories['Drama'], categories['Horror']]},
  {title: 'Revival', image: File.open("#{Rails.root}/app/assets/images/revival.jpg"), categories: [categories['Cookbooks'], categories['Horror']]},
  {title: 'Something Wicked', image: File.open("#{Rails.root}/app/assets/images/something_wicked.jpeg"), categories: [categories['Fantasy'], categories['Horror']]},
  {title: 'Enterprise web development', image: File.open("#{Rails.root}/app/assets/images/web_dev.png"), categories: [categories['Web development']]},
  {title: 'The truth about html5', image: File.open("#{Rails.root}/app/assets/images/web_development.jpg"), categories: [categories['Web development'], categories['Horror']]},
  {title: 'Easy baking', image: File.open("#{Rails.root}/app/assets/images/easy_baking.jpg"), categories: [categories['Cookbooks']]},
  {title: 'Cookbook', image: File.open("#{Rails.root}/app/assets/images/cookbook.jpg"), categories: [categories['Cookbooks']]},
  {title: 'Vegetarian cookbook', image: File.open("#{Rails.root}/app/assets/images/vegetarian_cookbook.jpg"), categories: [categories['Web development'], categories['Horror']]},
  {title: 'JavaScript&jQuery', image: File.open("#{Rails.root}/app/assets/images/javascript_jquery.png"), categories: [categories['Web development']]},
  {title: 'IT', image: File.open("#{Rails.root}/app/assets/images/it.png"), categories: [categories['Web development'], categories['Horror']]},
  {title: 'Flowers for Algernon', image: File.open("#{Rails.root}/app/assets/images/algernon_flowers.jpg"), categories:  [categories['Fantasy']]},
  {title: 'Cujo', image: File.open("#{Rails.root}/app/assets/images/cujo.jpeg"), categories: [categories['Drama'], categories['Horror']]},
  {title: 'Desperation', image: File.open("#{Rails.root}/app/assets/images/desperation.jpg"), categories: [categories['Horror']]},
  {title: 'Fahrenheit 451', image: File.open("#{Rails.root}/app/assets/images/fahrenheit451.jpg"), categories: [categories['Drama'], categories['Horror']]},
  {title: 'Revival', image: File.open("#{Rails.root}/app/assets/images/revival.jpg"), categories: [categories['Cookbooks'], categories['Horror']]},
  {title: 'Something Wicked', image: File.open("#{Rails.root}/app/assets/images/something_wicked.jpeg"), categories: [categories['Fantasy'], categories['Horror']]},
  {title: 'Enterprise web development', image: File.open("#{Rails.root}/app/assets/images/web_dev.png"), categories: [categories['Web development']]},
  {title: 'The truth about html5', image: File.open("#{Rails.root}/app/assets/images/web_development.jpg"), categories: [categories['Web development'], categories['Horror']]},
  {title: 'Easy baking', image: File.open("#{Rails.root}/app/assets/images/easy_baking.jpg"), categories: [categories['Cookbooks']]},
  {title: 'Cookbook', image: File.open("#{Rails.root}/app/assets/images/cookbook.jpg"), categories: [categories['Cookbooks']]},
  {title: 'Vegetarian cookbook', image: File.open("#{Rails.root}/app/assets/images/vegetarian_cookbook.jpg"), categories: [categories['Web development'], categories['Horror']]}
  ].map do |book|
    { book[:title] => Book.create(
      title: book[:title], 
      short_description: FFaker::CheesyLingo.paragraph(rand(5..10)), 
      full_description: FFaker::CheesyLingo.paragraph(rand(30..40)),
      image: book[:image],
      price: rand(1.0..30.0).round(2),
      instock: rand(100..1000),
      categories: book[:categories],
      authors: (0..(rand(1..4))).map{ Author.all.sample }) }
  end.reduce(:merge)

#100.times do
#  Review.create(text: FFaker::CheesyLingo.paragraph(rand(5..10)),
#                book: Book.all.sample,
#                user: User.all.sample)
#end

[{code: '123456'},
 {code: '654321'},
 {code: '321654'}].each do |coupon|
  Coupon.create(code: coupon[:code],
                sale: rand(3..15))

User.create([{first_name: 'Test', last_name: 'Test', email: 'test@test.test', password: '123456' },
  {first_name: 'Admin', last_name: 'Admin', email: 'admin@admin.admin', password: '123456', admin: true },
  {first_name: 'Guest', last_name: 'Guest', email: 'login@login.login', password: 'password'}])
end