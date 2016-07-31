class ReviewsController < ApplicationController
  include Rectify::ControllerHelpers

  def new
    @review = Review.create(user: current_user, book: book)
  end

  def update
    @form = ReviewForm.from_params(review_params, id: params[:id])
    @review = review if @form.invalid?
    UpdateReview.call(@form) do
      on(:ok) { redirect_to book_path(review.book.id), notice: t(:comment_added) }
      on(:invalid) { render :new }
    end
  end

  private

    def review_params
      params.require(:review).permit(:text)
    end

    def book
      Book.find(params[:book_id])
    end

    def review
      Review.find(@form.id)
    end
end
