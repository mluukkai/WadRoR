class BeermappingAPI
  def self.locations_in(city)
    city = city.downcase
    Rails.cache.write(city, [fetch_locations_in(city), Time.now.to_i]) if not_cached? city

    Rails.cache.read(city).first
  end

  private

  def self.not_cached? city
    return true if not Rails.cache.exist?(city)
    time = Time.at(Rails.cache.read(city).last)
    #(time+7.days).past?
    (time+1.minute).past?
  end

  def self.fetch_locations_in(city)
    url = "http://beermapping.com/webservice/loccity/#{key}/"

    response = HTTParty.get "#{url}#{city.gsub(' ', '%20')}"
    locations = response.parsed_response["bmp_locations"]["location"]

    return [] if locations.is_a?(Hash) and locations['id'].nil?

    locations = [locations] if locations.is_a?(Hash)
    locations.inject([]) do | set, location|
      set << Location.new(location)
    end
  end

  def self.key
    "96ce1942872335547853a0bb3b0c24db"
  end
end