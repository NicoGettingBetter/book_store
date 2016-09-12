require 'rails_helper'

feature 'Settings' do
  before :all do
    @user = FactoryGirl.create(:user)
    @country = FactoryGirl.create(:country)
  end

  background do
    sign_in @user
    visit settings_path
  end

  scenario 'billing address with wrong fields' do
    page.find('#billing_address').click_button I18n.t(:save)
    expect(page).to have_content('error')
  end

  scenario 'shipping address with wrong fields' do
    page.find('#shipping_address').click_button I18n.t(:save)
    expect(page).to have_content('error')
  end

  scenario 'billing_address' do
    fill_in_addresses '#billing_address'
    check_address
  end

  scenario 'shipping_address' do
    fill_in_addresses '#shipping_address'
    check_address
  end
end

private
  def fill_in_addresses address
    div = page.find(address)
    div.fill_in :address_street, with: 'street'
    div.fill_in :address_city, with: 'city'
    div.select @country.name, from: :address_country_id
    div.fill_in :address_zipcode, with: '111'
    div.fill_in :address_phone, with: '+380111111111'
    div.click_button I18n.t(:save)
  end

  def check_address
    expect(page).to have_selector("input[value='street']")
    expect(page).to have_selector("input[value='city']")
    expect(page).to have_selector("input[value='111']")
    expect(page).to have_selector("input[value='+380111111111']")
  end
