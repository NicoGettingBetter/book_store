class BookPresenter < BasePresenter
  attribute :book, Book
  attribute :review, Review

  delegate :reviews, to: :book
  def approved_reviews
    Review.approved_reviews book
  end

  def by_authors
    t(:by) if book.authors.any?
  end

  def authors_links 
    safe_join(book.authors.map{ |author| link_to author.decorate.full_name, author }, (", ").html_safe)
  end

  def description 
    book.full_description.truncate(2000)
  end
end