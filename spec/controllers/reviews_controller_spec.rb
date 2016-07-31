require 'rails_helper'

RSpec.describe ReviewsController, :type => :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:book) { FactoryGirl.create(:book) }
  let(:valid_attributes) {
    {
      text: '11111',
      book: book,
      user: user
    }
  }

  let(:invalid_attributes) {
    {
      text: ''
    }
  }

  let(:valid_session) { {
    book_id: book.id
  } }

  describe "GET new" do
    it "assigns a new review as @review" do
      get :new, valid_session
      expect(assigns(:review)).to be_a(Review)
    end

    it "render :new template" do
      get :new, valid_session
      expect(response).to render_template(:new)
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:rate) { FactoryGirl.create(:rate) }

      let(:new_attributes) {
        {
          text: '222'
        }
      }

      it "updates the requested review" do
        review = Review.create! valid_attributes
        rate.update(rateable_id: review.id, rater_id: user.id)
        put :update, {id: review.to_param, review: new_attributes}
        review.reload
        expect(Review.find(review.id).text).to eq('222')
      end

      it "redirects to the book" do
        review = Review.create! valid_attributes
        rate.update(rateable_id: review.id, rater_id: user.id)
        put :update, {id: review.to_param, review: valid_attributes}
        expect(response).to redirect_to(book_path(review.book.id))
      end
    end

    describe "with invalid params" do
      it "assigns the review as @review" do
        review = Review.create! valid_attributes
        put :update, {id: review.to_param, review: invalid_attributes}
        expect(assigns(:review)).to eq(review)
      end

      it "re-renders the :new template" do
        review = Review.create! valid_attributes
        put :update, {id: review.to_param, review: invalid_attributes}
        expect(response).to render_template(:new)
      end
    end
  end
end