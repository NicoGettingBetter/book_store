require 'rails_helper'

RSpec.describe SettingsController, :type => :controller do
  describe 'GET index' do
    before do
      allow(controller).to receive(:get_address) { FactoryGirl.create(:address) }
    end
    
    it 'render index template' do 
      get :index
      expect(response).to render_template :index
    end
  end
end