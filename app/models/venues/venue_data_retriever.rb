class VenueDataRetriever

  FOURSQUARE_ID = Rails.application.secrets.foursquare_client_id
  FOURSQUARE_SECRET = Rails.application.secrets.foursquare_client_secret


  def self.select_venues(number, data)
    (1..number).map do |element|
      Venue.new(data['response']['groups'][0]['items'][element]["venue"]) 
    end
  end

  def self.request_foursquare_data(midpoint, options)
    fetch_json_from(build_foursquare_url(midpoint, options))
  end

  private

  def self.build_foursquare_url(midpoint, options)
    base_url = 'https://api.foursquare.com/v2/venues/explore?'
    keys = 'client_id=' + FOURSQUARE_ID + '&client_secret=' + FOURSQUARE_SECRET
    location = '&v=20130815&ll=' + midpoint.lat.to_s + ',' + midpoint.lng.to_s
    options = '&radius=500' + '&section=' + options
    base_url + keys + location + options
  end

  def self.fetch_json_from(url)
    data = Net::HTTP.get(URI.parse(URI.encode(url)))
    JSON.parse(data)
  end


end