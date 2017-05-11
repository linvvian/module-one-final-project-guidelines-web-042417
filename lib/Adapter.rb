require "open-uri"

class Adapter

  URL = "https://api.foursquare.com/v2/venues/explore?oauth_token=BFB4MQPP4ERNYF31Y3LC2XZUPRUPYB3PGDJZ4KGLE3OL0UBF&v=20170416&ll="

  def self.financial_district
    "#{URL}40.705061%2C%20-74.014230&section=food&limit=50#/"
  end

  def self.east_village
    "#{URL}40.723298%2C%20-73.988505&section=food&limit=50#/"
  end

  def self.gets_results
    response = open(Neighborhood.choose_neighborhood).read
    JSON.parse(response)
  end

end
