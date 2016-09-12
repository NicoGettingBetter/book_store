require 'rails_helper'

RSpec.describe User, type: :model do
  [:email,
    :first_name,
    :last_name].each do |field|
      it { should have_db_column(field) }
      it { should validate_presence_of(field) }
    end

  [:orders,
    :reviews].each do |field|
      it { should have_many(field) }
    end

  [:default_billing_address,
    :default_shipping_address].each do |field|
    it { should belong_to(field) }
  end

  it { should validate_presence_of(:password) }

  context 'current order' do
    it 'return new order' do
      expect(FactoryGirl.build(:user).current_order).to be_a(Order)
    end

    it 'return existed order' do
      user = FactoryGirl.create(:user)
      order = FactoryGirl.create(:order_in_progress, user: user)
      expect(user.current_order).to match(order)
    end
  end

  it 'has valid factory' do
    expect(FactoryGirl.build(:user)).to be_valid
  end
end
