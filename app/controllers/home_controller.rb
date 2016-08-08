class HomeController < ApplicationController
  include Rectify::ControllerHelpers

  def index
    present CarouselPresenter.new(books: Book.most_popular_books.map(&:decorate))
    @form = OrderItemForm.new
  end
end