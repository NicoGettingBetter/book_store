class BooksController < ApplicationController
  include Rectify::ControllerHelpers

  def show
    present BookPresenter.new(book: Book.find(params[:id]).decorate,
                              review: Review.find_or_create)
  end
end
