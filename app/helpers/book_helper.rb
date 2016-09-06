module BookHelper
  def authors_links book
    safe_join(book.authors.map{ |author| link_to author.decorate.full_name, author }, (", ").html_safe)
  end

  def by_authors book
    t(:by) if book.authors.any?
  end

  def description book, trunc = 2000
    book.short_description.truncate(trunc)
  end
end
