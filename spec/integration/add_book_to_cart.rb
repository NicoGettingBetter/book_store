require 'rails_helper'

feature 'Cart' do
  let(:user) { FactoryGirl.create(:user) }
  let(:book) { FactoryGirl.create(:book) }

  background do
    #Capybara.current_driver = :webkit  
    Capybara.current_driver = :selenium
    allow(Book).to receive(:all_instock) { [book] }
  end

  scenario 'add book to cart' do
    sign_in
    add_book
    go_to_cart
  end 

  private
    def sign_in
      login_as user, scope: :user
      visit root_path
      expect(page).to have_content('Sign out')
    end

    def add_book
      click_link('Shop')
      click_link("#{book.title}")
      login_as user, scope: :user
      click_button('Add to cart')
      expect(page).to have_content('Cart: (1)')
    end

    def go_to_cart
      click_link('Cart')
      fill_in 'order_order_item_1_quantity', with: '2'
      expect(page).to have_content((book.price*2).to_s)
    end
end