class CreateAdventures < ActiveRecord::Migration
  def change
    create_table :adventures do |t|
      t.integer :wallet
      t.references :user
      t.references :restaurant
    end
  end
end