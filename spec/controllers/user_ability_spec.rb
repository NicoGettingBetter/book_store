require 'rails_helper'

describe 'Ability' do
  let(:book){ FactoryGirl.create(:book)}
  let(:category){ FactoryGirl.create(:category)}
  let(:author){ FactoryGirl.create(:author)}

  describe 'of guest' do
    subject(:ability){ Ability.new(nil) }
    let(:order){ FactoryGirl.create(:order) }
    let(:order_item){ FactoryGirl.create(:order_item)}
    let(:review){ FactoryGirl.create(:review)}
    let(:rate){ FactoryGirl.create(:rate)}

    it { ability.should be_able_to(:read, rate)}
    it { ability.should be_able_to(:read, review)}
    it { ability.should be_able_to(:read, book)}
    it { ability.should be_able_to(:read, category)}
    it { ability.should be_able_to(:read, author)}
  end

  describe 'of user' do
    subject(:ability){ Ability.new(user) }
    let(:user){ FactoryGirl.create(:user) }
      let(:order){ FactoryGirl.create(:order, user: user) }
      let(:order_item){ FactoryGirl.create(:order_item, order: order)}
      let(:review){ FactoryGirl.create(:review, user: user)}
      let(:rate){ FactoryGirl.create(:rate, rater: user)}

    it { ability.should be_able_to(:manage, user) }
    it { ability.should be_able_to(:manage, order) }
    it {
      order_item.order.user.current_order
      ability.should be_able_to(:manage, order_item)
    }
    it { ability.should be_able_to(:update, review) }
    it { ability.should be_able_to(:create, rate) }
  end

  describe 'of admin' do
    subject(:ability){ Ability.new(user) }
    let(:user){ FactoryGirl.create(:admin) }
    let(:order){ FactoryGirl.create(:order) }
    let(:order_item){ FactoryGirl.create(:order_item)}
    let(:review){ FactoryGirl.create(:review)}
    let(:delivery){ FactoryGirl.create(:delivery)}
    let(:coupon){ FactoryGirl.create(:coupon)}

    it { ability.should be_able_to(:manage, order)}
    it { ability.should be_able_to(:manage, book)}
    it { ability.should be_able_to(:manage, review)}
    it { ability.should be_able_to(:manage, category)}
    it { ability.should be_able_to(:manage, author)}
    it { ability.should be_able_to(:manage, delivery)}
    it { ability.should be_able_to(:manage, coupon)}
    it { ability.should be_able_to(:manage, user)}
    it { ability.should be_able_to(:manage, order_item)}
  end
end
