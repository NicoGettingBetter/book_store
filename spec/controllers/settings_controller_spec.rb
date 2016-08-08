require 'rails_helper'

RSpec.describe SettingsController, :type => :controller do
  let(:user) { FactoryGirl.create(:user) }
  let!(:order) { FactoryGirl.create(:order, user: user) }
  describe 'GET index' do  
    before do
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
      allow(controller).to receive(:current_order).and_return(order)
    end
    
    it 'render index template' do 
      get :index
      expect(response).to render_template :index
    end
  end
end