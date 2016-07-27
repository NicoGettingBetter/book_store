class ShopController < ApplicationController
  include Rectify::ControllerHelpers
  helper BooksHelper

  def index
    present ShopPresenter.new(category: category,
                              categories: Category.has_books)
  end

private

  def shop_params_category
    params.require(:category).permit(:id)[:id] if params[:category]
  end

  def category
    params[:category] ? Category.find(shop_params_category) : nil
  end
end