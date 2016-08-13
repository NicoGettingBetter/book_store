require 'rails_helper'

feature 'edit cart' do
  include ActiveSupport::NumberHelper

  before :all do
    @coupon = Coupon.create(FactoryGirl.attributes_for(:coupon))
    @user = FactoryGirl.create(:user)
    @book = FactoryGirl.create(:book)
  end
  given!(:order) { @user.current_order }

  after :all do
    @book.delete
  end

  background do
    sign_in @user
    add_book @book
  end

  after do
    empty_cart
  end

  scenario 'update order item' do
    update_order_item(2)
    expect(page).to have_content((@book.price*2).to_s)
  end

  scenario 'add coupon' do
    add_coupon @coupon.code
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
    expect(page).not_to have_content(@book.title)
    add_book @book
  end

  scenario 'delete order' do
  end
end

feature 'checkout' do
  before :all do
    @country = FactoryGirl.create(:country)
    @user = FactoryGirl.create(:user)
    @delivery = FactoryGirl.create(:delivery)
    @book = FactoryGirl.create(:book)
  end

  after :all do
    @book.delete
  end

  background do
    sign_in @user
    add_book @book
    go_to_checkout
  end

  after do
    empty_cart
  end

  feature 'address' do
    scenario 'set addresses' do
      set_address
      expect(page).to have_content(@delivery.company)
    end

    scenario 'set same addresses' do
      fill_in_billing_address
      check :use_billing_address_check
      click_button I18n.t(:save_and_continue)
      expect(page).to have_content(@delivery.company)
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
      set_delivery
      expect(page).to have_content(I18n.t(:credit_card))
    end

    scenario 'was not chosen' do
      click_button I18n.t(:save_and_continue)
      expect(page).to have_content('error')
    end
  end

  feature 'payment' do
    background do
      set_address
      set_delivery
    end

    scenario 'set payment' do
      set_payment
      expect(page).to have_selector("input[type=submit][value='#{I18n.t(:place_order)}']")
    end

    scenario 'with wrong fields' do
      click_button I18n.t(:save_and_continue)
      expect(page).to have_content('error')
    end
  end

  feature 'confirm' do
    background do
      set_address
      set_delivery
      set_payment
    end

    scenario 'place order' do
      click_button I18n.t(:place_order)
      expect(page).to have_selector("input[type=submit][value='#{I18n.t(:go_back_to_store)}']")
      add_book @book
    end
  end
end

private

  def update_order_item count
    click_link(I18n.t(:cart))
    fill_in "order_order_items_#{@book.order_items.first.id}_quantity", with: count
    click_button(I18n.t(:update))
  end

  def add_book book_from_carousel
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
    select @country.name, from: 'billing_address_country_id'
    fill_in 'billing_address_zipcode', with: '123'
    fill_in 'billing_address_phone', with: '+380111111111'
  end

  def fill_in_shipping_address
    fill_in 'shipping_address_street', with: 'street'
    fill_in 'shipping_address_city', with: 'city'
    select @country.name, from: 'shipping_address_country_id'
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

  def set_delivery
    choose :"order_shipping_#{@delivery.id}"
    click_button I18n.t(:save_and_continue)
  end

  def set_payment
    fill_in :credit_card_number, with: '1234123412341234'
    select 'May', from: :credit_card_expiration_month
    select '2017', from: :credit_card_expiration_year
    fill_in :credit_card_cvv, with: '123'
    click_button I18n.t(:save_and_continue)
  end
