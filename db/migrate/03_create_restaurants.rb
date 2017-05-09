class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.integer :rating
      t.string :tips
      t.string :category
      t.integer :price
      t.integer :zip_code
      t.string :api_id
    end
  end
end