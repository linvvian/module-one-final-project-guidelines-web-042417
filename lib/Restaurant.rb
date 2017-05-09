class Restaurant < ActiveRecord::Base

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

end
