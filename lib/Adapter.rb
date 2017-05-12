require "open-uri"

class Adapter

  URL = "https://api.foursquare.com/v2/venues/explore?oauth_token=BFB4MQPP4ERNYF31Y3LC2XZUPRUPYB3PGDJZ4KGLE3OL0UBF&v=20170416&ll="

  def self.hood_urls
    {financial_district: "#{URL}40.705061%2C%20-74.014230&section=food&limit=50#/",
    east_village: "#{URL}40.723298%2C%20-73.988505&section=food&limit=50#/",
    greenpoint: "#{URL}40.732724%2C%20-73.951282&section=food&limit=50#/",
    downtown_brooklyn: "#{URL}40.693243%2C%20-73.984567&section=food&limit=50#/",
    astoria: "#{URL}40.765165%2C%20-73.923519&section=food&limit=50#/",
    flushing: "#{URL}40.769450%2C%20-73.830029&section=food&limit=50#/",
    staten_island: "#{URL}40.640184%2C%20-74.091553&section=food&limit=50#/",
    bronx: "#{URL}40.829624%2C%20-73.910453&section=food&limit=50#/"}
  end

  def self.gets_results
    responses = self.hood_urls.values
    responses.map do |response|
      JSON.parse(open(response).read)
    end
  end

end
