class BooksController < ApplicationController
  include Rectify::ControllerHelpers

  def show
    present BookPresenter.new(book: book,
                              order_item: order_item)
  end

  private 

    def book
      Book.find(params[:id]).decorate
    end

    def order_item
      return OrderItem.new(quantity: 1) unless current_user
      OrderItem.exist_or_new(current_order, book)
    end
end
