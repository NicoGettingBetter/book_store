class CreateCreditCards < ActiveRecord::Migration[5.0]
  def change
    create_table :credit_cards do |t|
      t.string :number
      t.integer :cvv
      t.string :expiration_month
      t.integer :expiration_year

      t.uuid :order_id

      t.timestamps
    end
  end
end
