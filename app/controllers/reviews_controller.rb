class ReviewsController < ApplicationController

  def update
    @form = ReviewForm.from_params(review_params, 
      user: current_user, 
      book: Book.find(review_params[:book_id]))
    UpdateReview.call(@form) do
      on(:ok) { redirect_to :back }
      on(:invalid) { redirect_to :back }
    end
  end

  private
    def review_params
      params.require(:review).permit(:id, :text, :book_id)
    end
end
