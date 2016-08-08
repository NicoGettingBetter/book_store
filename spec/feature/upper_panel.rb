require 'rails_helper'

feature 'links for everyone' do
  scenario 'The Bookstore' do
    visit shop_path
    click_link('The Bookstore')
    expect(current_path).to eq(root_path)
  end

  scenario 'Home' do
    visit shop_path
    click_link(I18n.t(:home))
    expect(current_path).to eq(root_path)
  end

  scenario 'Shop' do
    visit root_path
    click_link(I18n.t(:shop))
    expect(current_path).to eq(shop_path)
  end
end

feature 'links as unregistered user' do
  scenario 'Sign in' do
    visit root_path
    click_link(I18n.t(:sign_in))
    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'Sign up' do
    visit root_path
    click_link(I18n.t(:sign_up))
    expect(current_path).to eq(new_user_registration_path)
  end
end

feature 'links as registeger user' do
  before :all do
    @user = FactoryGirl.create(:user)
    @order = @user.current_order
  end
  given(:book) { FactoryGirl.create(:book) }

  background do
    Capybara.current_driver = :webkit
    allow(Book).to receive(:all_instock) { [book] }
    sign_in @user
  end

  scenario 'Cart' do
    add_book book
    visit root_path
    click_link(I18n.t(:cart))
    expect(current_path).to eq(edit_order_path(@order.id))
  end

  scenario 'Settings' do
    visit root_path
    click_link(I18n.t(:settings))
    expect(current_path).to eq(settings_path)
  end

  scenario 'Orders' do
    visit root_path
    click_link(I18n.t(:orders))
    expect(current_path).to eq(orders_path)
  end

  scenario 'Sign out' do
    visit shop_path
    click_link(I18n.t(:sign_out))
    expect(page).to have_content(I18n.t(:sign_in))
  end
end

private

  def add_book book
    visit shop_path
    expect(page).to have_content(book.title)
    click_link(book.title)
    click_button(I18n.t(:add_to_cart))
    expect(page).to have_content('Cart:(1)')
  end
