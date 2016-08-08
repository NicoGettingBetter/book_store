class CreateDeliveries < ActiveRecord::Migration[5.0]
  def change
    create_table :deliveries do |t|
      t.string :company
      t.string :delivery_method
      t.float :price

      t.uuid :order_id

      t.timestamps
    end
  end
end
