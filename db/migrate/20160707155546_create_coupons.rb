class CreateCoupons < ActiveRecord::Migration[5.0]
  def change
    create_table :coupons do |t|
      t.string :code
      t.integer :sale

      t.uuid :order_id

      t.timestamps
    end
  end
end
