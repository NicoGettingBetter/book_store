require 'rails_helper'

feature 'navigate by categories' do
  before :all do
    @category = FactoryGirl.create(:category)
    FactoryGirl.create(:book, categories: [@category])
  end

  background do
    Capybara.current_driver = :webkit
  end

  scenario 'open category' do
    visit shop_path
    click_link @category.name
    expect(page.find('#breadcrumbs')).to have_css('a', text: @category.name)
  end
end
