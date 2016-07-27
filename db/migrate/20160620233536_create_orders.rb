class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders, id: :uuid do |t|
      t.string :state, default: :in_progress
      t.float :total_price
      t.datetime :completed_date

      t.references :billing_address
      t.references :shipping_address
      t.references :coupon
      t.references :user
      t.references :delivery

      t.timestamps
    end
  end
end
