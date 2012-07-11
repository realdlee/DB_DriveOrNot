#this is a simple program that checks to see if it is raining or snowing.  If # it is then the program will return a boolean value of true.  Otherwise, the program will return false (indicating that weather is not a factor in the decision to Drive or Not
#future implementation: check what cities Traveler will visit; check temperature (instead of just 'condition').  Now only checks weather in San Francisco

require 'open-uri'
require 'nokogiri'

class Weather
  def initialize #day_of_week
    #     @day_of_week = day_of_week
    @bad_weather = false
    @doc = Nokogiri::XML(open("http://www.google.com/ig/api?weather=San+Francisco"))
    weather_stuff = @doc.xpath('//condition')
    today = weather_stuff.first.to_s
    # tomorrow = weather_stuff[1].to_s
    if (today.include?("Rain")) || (today.include?("Snow") || (today.include?("storm"))  #only checks today's weather but want to check the ACTUAL day of travel
      @bad_weather = true
    end
    return @bad_weather
  end
end

@w = Weather.new
