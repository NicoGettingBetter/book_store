require 'rails_helper'

RSpec.describe Author, type: :model do
  [:first_name,
    :last_name,
    :description].each do |field|
      it { should have_db_column(field) }
    end

  [:first_name,
    :last_name].each do |field|
      it { should validate_presence_of(field) }
    end

  it { should have_and_belong_to_many(:books) }

  it 'has valid factory' do
    expect(FactoryGirl.build(:author)).to be_valid
  end
end
