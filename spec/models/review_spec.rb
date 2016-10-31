require 'rails_helper'

RSpec.describe Review, type: :model do
  it { should belong_to(:book) }

  context 'approved reviews' do
    let!(:book) { FactoryGirl.create(:book) }

    before do
      @reviews = FactoryGirl.create_list(:review, 5, book: book)
      @reviews_without_book = FactoryGirl.create_list(:review, 5)
    end

    it 'returns all approved reviews' do
      expect(book.reviews.approved_reviews).to match_array(@reviews)
    end
  end
end
