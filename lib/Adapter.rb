require "open-uri"

class Adapter
  URL = "https://api.foursquare.com/v2/venues/explore?oauth_token=BFB4MQPP4ERNYF31Y3LC2XZUPRUPYB3PGDJZ4KGLE3OL0UBF&v=20170416&ll=40.705061%2C%20-74.014230&section=food&limit=50#/"

  def self.gets_results
    response = open(URL).read
    JSON.parse(response)
  end

end
