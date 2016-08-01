require 'rails_helper'

feature 'add book to cart' do
  before :all do
    @user = FactoryGirl.create(:user)
  end
  given(:book) { FactoryGirl.create(:book) }

  background do
    Capybara.current_driver = :webkit
    allow(Book).to receive(:all_instock) { [book] }
    sign_in
  end

  after do
    empty_cart
  end

  scenario 'from show' do
    add_book
  end

  scenario 'from carousel' do
    add_book_from_carousel
  end
end



feature 'edit cart' do
  include ActiveSupport::NumberHelper

  before :all do
    @user = FactoryGirl.create(:user)
    Capybara.current_driver = :webkit
  end
  given(:book) { FactoryGirl.create(:book) }
  given(:coupon) { FactoryGirl.create(:coupon) }
  given!(:order) { @user.current_order }

  background do
    allow(Book).to receive(:all_instock) { [book] }
    allow(Coupon).to receive(:all_available) { [coupon] }
    sign_in
    add_book
  end

  after do
    empty_cart
  end

  scenario 'update order item' do
    update_order_item(2)
    expect(page).to have_content((book.price*2).to_s)
  end

  scenario 'add coupon' do
    add_coupon coupon.code
    expect(page).to have_content(I18n.t(:sale))
  end

  scenario 'wrong coupon' do
    add_coupon '0000'
    expect(page).to have_content('error')
  end

  scenario 'move to shop' do
    click_link(I18n.t(:cart))
    click_link I18n.t(:continue_shopping)
    expect(page).to have_content(I18n.t(:shop))
  end

  scenario 'delete order item' do
    click_link(I18n.t(:cart))
    click_link 'x'
    expect(page).not_to have_content(book.title)
  end

  scenario 'delete order' do
    empty_cart
  end
end

feature 'checkout' do
  before :all do
    @user = User.create(email: 'test@test.com',
                        password: '123456',
                        first_name: '111',
                        last_name: '222')
  end

  after :all do
    @user.delete
  end

  given(:book) { FactoryGirl.create(:book) }
  given(:delivery) { FactoryGirl.create(:delivery) }
  given!(:country) { FactoryGirl.create(:country) }

  background do
    Capybara.current_driver = :webkit
    allow(Book).to receive(:all_instock) { [book] }
    sign_in
    add_book
    go_to_checkout
  end

  after do
    empty_cart
  end

  feature 'address' do
    scenario 'set addresses' do
      set_address
      expect(page).to have_content(delivery.company)
    end

    scenario 'set same addresses' do
      fill_in_billing_address
      check t(:use_billing_address)
      click_button I18n.t(:save_and_continue)
      expect(page).to have_content(delivery.company)
    end

    scenario 'with wrong fields' do
      click_button I18n.t(:save_and_continue)
      expect(page).to have_content('error')
    end
  end

  feature 'delivery' do
    background do
      set_address
    end

    scenario 'set delivery' do
      check delivery.company
      click_button I18n.t(:save_and_continue)
      expect(page).to have_content(I18n.t(:credit_card))
    end

    scenario 'was not chosen' do
      click_button I18n.t(:save_and_continue)
      expect(page).to have_content('error')
    end
  end
end

  private

    def sign_in
      login_as @user, scope: :user, run_callbacks: false
      visit root_path
      expect(page).to have_content('Sign out')
    end

    def add_book
      visit shop_path
      click_link(book.title)
      click_button(I18n.t(:add_to_cart))
      expect(page).to have_content('Cart:(1)')
    end

    def update_order_item count
      click_link(I18n.t(:cart))
      fill_in "order_order_items_#{book.order_items.first.id}_quantity", with: count
      click_button(I18n.t(:update))
    end

    def add_book_from_carousel
      visit root_path
      click_button(I18n.t(:add_to_cart))
      expect(page).to have_content('Cart:(1)')
    end

    def add_coupon code
      click_link(I18n.t(:cart))
      fill_in 'order_coupon', with: code
      click_button(I18n.t(:update))
    end

    def go_to_checkout
      click_link I18n.t(:cart)
      click_link I18n.t(:checkout)
    end

    def fill_in_billing_address
      fill_in 'billing_address_street', with: 'street'
      fill_in 'billing_address_city', with: 'city'
      select country.name, from: 'billing_address_country_id'
      fill_in 'billing_address_zipcode', with: '123'
      fill_in 'billing_address_phone', with: '+380111111111'
    end

    def fill_in_shipping_address
      fill_in 'shipping_address_street', with: 'street'
      fill_in 'shipping_address_city', with: 'city'
      select country.name, from: 'shipping_address_country_id'
      fill_in 'shipping_address_zipcode', with: '123'
      fill_in 'shipping_address_phone', with: '+380111111111'
    end

    def set_address
      fill_in_billing_address
      fill_in_shipping_address
      click_button I18n.t(:save_and_continue)
    end

    def empty_cart
      click_link(I18n.t(:cart))
      click_link I18n.t(:empty_cart)
      expect(page).to have_content(I18n.t(:you_have_an_empty_cart))
    end
