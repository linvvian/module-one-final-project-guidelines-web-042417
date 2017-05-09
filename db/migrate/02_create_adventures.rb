class CreateAdventures < ActiveRecord::Migration
  def change
    create_table :adventures do |t|
      t.integer :wallet
      t.integer :score
      t.references :user
    end
  end
end