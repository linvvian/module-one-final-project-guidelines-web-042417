class MealChoice < ActiveRecord::Base
  include Speak

  belongs_to :adventures
  belongs_to :restaurants

  def self.chosen_meal(adv_id, rest_id) # this is what goes away
    m = MealChoice.create(adventure_id: adv_id, restaurant_id: rest_id)
    m
  end

  def self.show_top_restaurants
    puts @@d.asciify('TOP 5 RESTUARANTS').light_magenta.bold
    puts "................................................"
    self.all.group(:restaurant_id).order("count(restaurant_id) desc").limit(5).count.each do |k,v|
      puts "* #{Restaurant.find(k).name} - #{v} Picks *".green
      puts "................................................"
    end
  end
end
