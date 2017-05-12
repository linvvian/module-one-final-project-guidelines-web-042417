class MealChoice < ActiveRecord::Base
  include Speak

  belongs_to :adventures
  belongs_to :restaurants

  def self.chosen_meal(adv_id, rest_id) # this is what goes away
    m = MealChoice.create(adventure_id: adv_id, restaurant_id: rest_id)
    m
  end
end
