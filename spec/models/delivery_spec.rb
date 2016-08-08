require 'rails_helper'

RSpec.describe Delivery, :type => :model do
  [:company,
    :delivery_method,
    :price].each do |field|
      it { should have_db_column(field) }
      it { should validate_presence_of(field) }
    end

  it { should have_many(:orders) }

  it 'has valid factory' do
    expect(FactoryGirl.build(:delivery)).to be_valid
  end
end
