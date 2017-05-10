class CreateMealChoices < ActiveRecord::Migration
  def change
    create_table :meal_choices do |t|
      t.references :adventure
      t.references :restaurant
    end
  end
end
