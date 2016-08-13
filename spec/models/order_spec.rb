require 'rails_helper'

RSpec.describe Order, :type => :model do
  [:state,
    :total_price,
    :completed_date,
    :billing_address_id,
    :shipping_address_id,
    :coupon_id,
    :user_id,
    :delivery_id].each do |field|
      it { should have_db_column(field) }
    end

  [:user,
    :billing_address,
    :shipping_address,
    :delivery].each do |field|
      it { should belong_to(field) }
    end

  [:credit_card,
    :coupon].each do |field|
    it { should have_one(field) }
  end

  it { should have_many(:order_items) }

  context 'scopes of state' do
    states = [:in_progress, :in_queue, :in_delivery, :delivered]
    before do
      @user = FactoryGirl.create(:user)
      @order = {}
      states.each do |field|
          @order[field] = FactoryGirl.create(:"order_#{field}", user: @user)
        end
    end

    states.each do |field|
      it "returns list of orders #{field}" do
        expect(@user.orders.send(field)).to match_array([@order[field]])
      end
    end
  end

  it 'has valid factory' do
    expect(FactoryGirl.build(:order)).to be_valid
  end
end
