class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string :first_name
      t.string :last_name
      t.string :street
      t.integer :zipcode
      t.string :city
      t.string :phone

      t.references :country

      t.timestamps
    end
  end
end
