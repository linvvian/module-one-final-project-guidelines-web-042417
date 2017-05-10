class Meal_Choice < ActiveRecord::Base
  belongs_to :adventures
  belongs_to :restaurants
end
