require 'rails_helper'

RSpec.describe Review, type: :model do
  it { should belong_to(:book) }

  context 'approved reviews' do
    let!(:book) { FactoryGirl.create(:book) }

    before do
      @reviews = FactoryGirl.create_list(:review, 5)
      @reviews_without_book = FactoryGirl.create_list(:review, 5)
      @reviews.each { |review| review.update(book: book) }
    end

    it 'returns all approved reviews' do
      expect(Review.approved_reviews(book)).to match_array(@reviews)
    end
  end
end
