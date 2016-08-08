require 'rails_helper'

RSpec.describe BooksController, :type => :controller do
  describe 'GET show' do
    it 'render show template' do 
      book = FactoryGirl.create(:book)
      get :show, { id: book.id }
      expect(response).to render_template :show
    end
  end
end