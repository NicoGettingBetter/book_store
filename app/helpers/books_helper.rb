module BooksHelper
  def all_instock_books books 
    books.select { |book| book.instock > 0 }
  end
end
