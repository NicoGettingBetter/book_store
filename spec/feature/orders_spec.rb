require 'rails_helper'

feature 'orders page' do
  before :all do
    @user = FactoryGirl.create(:user)
    @delivery = FactoryGirl.create(:delivery)
    @order_in_queue = FactoryGirl.create(:order_in_queue, user: @user, delivery: @delivery)
    @book = FactoryGirl.create(:book)
  end

  after :all do
    @book.delete
  end

  background do
    sign_in @user
  end

  scenario 'open cart' do
    add_book @book
    visit orders_path
    click_button(I18n.t(:go_to_cart))
    expect(page).to have_css('a', I18n.t(:checkout))
  end

  scenario 'open order' do
    visit_order_in_queue
    expect(current_path).to eq(order_path(@order_in_queue.id))
  end
end

feature 'show order' do
  before :all do
    @user = FactoryGirl.create(:user)
    @delivery = FactoryGirl.create(:delivery)
    @order_in_queue = FactoryGirl.create(:order_in_queue, user: @user, delivery: @delivery)
    @book = FactoryGirl.create(:book)
  end

  after :all do
    @book.delete
  end

  background do
    sign_in @user
  end

  scenario 'back to orders' do
    visit_order_in_queue
    click_link(I18n.t(:back_to_orders))
    expect(current_path).to eq(orders_path)
  end
end

private

  def visit_order_in_queue
    visit orders_path
    click_link(@order_in_queue.id)
  end
