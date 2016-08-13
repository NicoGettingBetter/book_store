require 'rails_helper'

RSpec.describe Book, :type => :model do
  [:title,
    :short_description,
    :full_description,
    :image,
    :instock,
    :price].each do |field|
      it { should have_db_column(field) }
    end

  [:title,
    :short_description,
    :full_description,
    :image,
    :instock,
    :price].each do |field|
      it { should validate_presence_of(field) }
    end

  [:authors,
    :categories].each do |field|
      it { should have_and_belong_to_many(field) }
    end

  [:reviews,
    :order_items].each do |field|
      it { should have_many(field) }
    end

  [:price,
    :instock].each do |field|
      it { should validate_numericality_of(field) }
    end

  context 'all instock' do
    before do
      @books = FactoryGirl.create_list(:book, 3)
      @out_of_stock_books = FactoryGirl.create_list(:out_of_stock_book, 3)
    end

    it 'returns list of books' do
      expect(Book.all_instock).to match_array(@books)
    end

    it 'returns list of books without books out of stock' do
      expect(Book.all_instock).not_to match_array(@out_of_stock_books)
    end
  end

  context 'most popular books' do
    before do
      @books = FactoryGirl.create_list(:book, 3)
    end

    it 'returns list of books' do
      expect(Book.most_popular_books).to match_array(@books)
    end
  end

  context 'sold books' do
    it 'decreases instock' do
      book = FactoryGirl.create(:book)
      instock = book.instock
      expect{ book.sold_books(1) }.to change{ book.instock }.by(-1)
    end
  end

  it 'have valid factory' do
    expect(FactoryGirl.build(:book)).to be_valid
  end
end
