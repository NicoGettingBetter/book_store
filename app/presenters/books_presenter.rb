class BooksPresenter < Rectify::Presenter
  def books
    Book.all_instock
  end

  def lines count = 4
    books.each_slice(count).to_a
  end
end
