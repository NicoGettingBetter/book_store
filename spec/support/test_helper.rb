module TestHelper
  def sign_in user
    login_as user, scope: :user, run_callbacks: false
    visit root_path
    expect(page).to have_content('Sign out')
  end
  
  def add_book book
    visit shop_path
    expect(page).to have_content(book.title)
    click_link(book.title)
    click_button(I18n.t(:add_to_cart))
    expect(page).to have_content('Cart:(1)')
  end
end
