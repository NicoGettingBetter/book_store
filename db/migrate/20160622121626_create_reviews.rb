class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.text :text
      t.boolean :approved, default: false

      t.references :user
      t.references :book

      t.timestamps
    end
  end
end
