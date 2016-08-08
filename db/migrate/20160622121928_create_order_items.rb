class CreateOrderItems < ActiveRecord::Migration[5.0]
  def change
    create_table :order_items do |t|
      t.float :price
      t.integer :quantity

      t.uuid :order_id
      t.references :book

      t.timestamps
    end
  end
end
