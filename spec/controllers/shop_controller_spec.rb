require 'rails_helper'

RSpec.describe ShopController, :type => :controller do
  describe 'GET index' do    
    it 'render index template' do 
      get :index
      expect(response).to render_template :index
    end
  end
end