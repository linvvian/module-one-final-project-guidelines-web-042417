class Restaurant < ActiveRecord::Base
  include Speak

  has_many :meal_choices
  has_many :adventures, through: :meal_choices

  def self.parse_restaurants
    results = []
    Adapter.gets_results.each do |neighborhood|
      neighborhood["response"]["groups"][0]["items"].each do |restaurant|
        hash = {}
        if restaurant["venue"]["price"] != nil
          hash[:price] = restaurant["venue"]["price"]["tier"]
        else
          hash[:price] = 0
        end
        # restaurant db id
        hash[:api_id] = restaurant["venue"]["id"],
        # restaurant name
        hash[:name] = restaurant["venue"]["name"],
        # restaurant zip code
        hash[:zip_code] = restaurant["venue"]["location"]["postalCode"],
        # restaurant category ie. Cuban Restaurant, Italian Restaurant
        hash[:category] = restaurant["venue"]["categories"][0]["name"],
        # restaurant rating score
        hash[:rating] = restaurant["venue"]["rating"],
        # restaurant tip text content
        if restaurant["tips"] != nil
          hash[:tips] = restaurant["tips"][0]["text"]
        else
          hash[:tips] = "Here's a blurb: Eat somewhere else."
        end
        results << hash
      end
    end
    results
  end

  def self.insert_to_table
    parse_restaurants.each do |rest_hash|
      self.create(rest_hash)
    end
  end

  def self.random_restaurant
    x = Neighborhood.picks_hood
    self.find(x)
  end

  def self.show_top_restaurants
    puts @@d.asciify('TOP 5 RESTUARANTS').light_magenta.bold
    puts "................................................"
    MealChoice.all.group(:restaurant_id).order("count(restaurant_id) desc").limit(5).count.each do |k,v|
      puts "* #{self.find(k).name} - #{v} Picks *".green
      puts "................................................"
    end
  end
end
