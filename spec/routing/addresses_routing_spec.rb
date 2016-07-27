require "rails_helper"

RSpec.describe AddressesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/address").to route_to("address#index")
    end

    it "routes to #new" do
      expect(:get => "/address/new").to route_to("address#new")
    end

    it "routes to #show" do
      expect(:get => "/address/1").to route_to("address#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/address/1/edit").to route_to("address#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/address").to route_to("address#create")
    end

    it "routes to #update" do
      expect(:put => "/address/1").to route_to("address#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/address/1").to route_to("address#destroy", :id => "1")
    end

  end
end
