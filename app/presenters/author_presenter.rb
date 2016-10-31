class AuthorPresenter < Rectify::Presenter
  attribute :author, Author

  def lines count = 5
    author.books.decorate.each_slice(count).to_a
  end
end
