class BasePresenter < Rectify::Presenter
  def image book, hash
    image_tag(book.image, hash)
  end
end