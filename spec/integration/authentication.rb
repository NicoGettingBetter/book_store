require 'rails_helper'

feature "the signin process", js: true do
  let(:user) { FactoryGirl.create(:test_user) }
  background do
    Capybara.current_driver = :webkit  
  end

  scenario "signs me in" do
    login_as user, scope: :user
    visit root_path
    expect(page).to have_content('Sign out')
    #Warden.test_reset!   
  end
end