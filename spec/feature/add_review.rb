require 'rails_helper'

feature 'add_review' do
  before :all do
    @user = FactoryGirl.create(:user)
  end
  given(:book) { FactoryGirl.create(:book) }

  background do
    Capybara.current_driver = :webkit
    allow(Book).to receive(:all_instock) { [book] }
    sign_in @user
  end

  scenario 'add review' do
    visit book_path(book.id)
    click_link I18n.t(:add_comment)
    fill_in :review_text, with: '111'
    find("img[alt='3']").click
    click_button I18n.t(:comment)
    expect(page).to have_content(book.title)
  end

  scenario 'with wrong fields' do
    visit book_path(book.id)
    click_link I18n.t(:add_comment)
    click_button I18n.t(:comment)
    expect(page).to have_content('error')
  end
end
