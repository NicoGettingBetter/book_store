require 'rails_helper'

RSpec.describe Category, :type => :model do
  it { should have_db_column(:name) }
  it { should validate_presence_of(:name) }
  it { should have_and_belong_to_many(:books)}
  it 'has valid factory' do
    expect(FactoryGirl.build(:category)).to be_valid
  end
end
