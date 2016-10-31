class ShopPresenter < BooksPresenter
  attribute :categories, Category
  attribute :category, Category

  def books count = 12
    books = category ? category.books.all_instock : Book.all_instock
    Kaminari.paginate_array(books.decorate).page(params[:page]).per(count)
  end

  def current_category
    category.name
  end

  def header
    safe_join([(link_to t(:home), root_path),
               (link_to t(:shop), shop_path),
               (link_to category.name,
                shop_path(category: { id: category.id }))], ' >> '.html_safe) if category
  end

  def categories_links
    categories.map{ |category| link_to category.name, shop_path(category: {id: category.id }) }
  end
end
