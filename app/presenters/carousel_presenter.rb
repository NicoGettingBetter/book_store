class CarouselPresenter < Rectify::Presenter
  attribute :books, Book
  attribute :order_item, OrderItem

  def by_authors book
    t(:by) if book.authors.any?
  end

  def authors_links book
    safe_join(book.authors.map{ |author| link_to author.decorate.full_name, author }, (", ").html_safe)
  end

  def description book
    book.short_description.truncate(300)
  end
end
