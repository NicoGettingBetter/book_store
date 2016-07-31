class AuthorPresenter < BasePresenter
  attribute :author, Author

  def lines count = 5
    author.books.map(&:decorate).each_slice(count).to_a
  end
end