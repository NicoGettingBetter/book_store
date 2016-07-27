require 'rails_helper'

RSpec.describe "Address", :type => :request do
  describe "GET /address" do
    it "works! (now write some real specs)" do
      get addres_path
      expect(response).to have_http_status(200)
    end
  end
end
