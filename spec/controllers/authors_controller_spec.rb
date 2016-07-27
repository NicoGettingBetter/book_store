require 'rails_helper'

RSpec.describe AuthorsController, :type => :controller do
  describe 'GET show' do
    it 'render show template' do
      author = FactoryGirl.create(:author)
      get :show, { id: author.id }
      expect(response).to render_template :show
    end
  end
end