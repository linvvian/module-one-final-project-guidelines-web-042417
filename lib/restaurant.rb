class Restaurant < ActiveRecord::Base
  has_many :meal_choices
  has_many :adventures, through: :meal_choices

  def self.parse_restaurants
    results = []
    Adapter.gets_results["response"]["groups"][0]["items"].each do |restaurant|
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
      hash[:tips] = restaurant["tips"][0]["text"]
      results << hash
    end
    results
  end

  def self.insert_to_table
    parse_restaurants.each do |rest_hash|
      self.create(rest_hash)
    end
  end

  def self.random_restaurant
    # x = rand(1..50)
    # self.find(x)
    self.all.sample
  end
end
