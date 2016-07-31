class AuthorsController < ApplicationController
  include Rectify::ControllerHelpers

  def show
    present AuthorPresenter.new(author: Author.find(params[:id]).decorate)
  end
end
