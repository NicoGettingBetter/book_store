require 'rails_helper'

feature 'add book to cart' do
  before :all do
    @user = FactoryGirl.create(:user)
  end
  given(:book) { FactoryGirl.create(:book) }

  background do
    Capybara.current_driver = :webkit
    allow(Book).to receive(:all_instock) { [book] }
    sign_in @user
  end

  after do
    empty_cart
  end

  scenario 'from show' do
    add_book book
  end

  scenario 'from carousel' do
    add_book_from_carousel
  end
end

feature 'call links on book' do
  before :all do
    @author = FactoryGirl.create(:author)
    @book = FactoryGirl.create(:book, authors: [@author])
  end

  background do
    Capybara.current_driver = :webkit
    allow(Book).to receive(:all_instock) { [@book] }
  end

  scenario 'open author from carousel' do
    visit root_path
    click_link(@book.authors.first.first_name)
    expect(current_path).to eq(author_path(@author))
  end

  scenario 'open author from book' do
      visit book_path(@book.id)
      click_link(@book.authors.first.first_name)
      expect(current_path).to eq(author_path(@author))
  end

  scenario 'open book from carousel' do
      visit root_path
      click_link(@book.title)
      expect(current_path).to eq(book_path(@book.id))
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

  def add_book_from_carousel
    visit root_path
    click_button(I18n.t(:add_to_cart))
    expect(page).to have_content('Cart:(1)')
  end

  def empty_cart
    click_link(I18n.t(:cart))
    click_link I18n.t(:empty_cart)
    expect(page).to have_content(I18n.t(:you_have_an_empty_cart))
  end
