require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  [:price,
    :quantity,
    :order_id,
    :book_id].each do |field|
      it { should have_db_column(field) }
    end

    [:order,
      :book].each do |field|
        it { should belong_to(field) }
      end

  it 'has valid factory' do
    expect(FactoryGirl.build(:order_item)).to be_valid
  end
end
