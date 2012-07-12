require 'rest-client'
require 'json'
require 'nokogiri'
require 'crack'
BART_API_KEY = "5SHZ-XLUS-U9U5-MN24"

class BadArgumentException < Exception; end;

module MapsAPIClient
  MAPS_URL = "http://maps.googleapis.com/maps/api/directions/json"

  def self.get(params = {})
    @response_hash = JSON.parse(RestClient.get(MAPS_URL, :params => params), :symbolize_names => true)
  end

  def self.response
    {:duration => @response_hash[:routes][0][:legs][0][:duration][:value],
     :distance => @response_hash[:routes][0][:legs][0][:distance][:value],
     :arrival_stop_name =>"foo",
     :departure_stop_name => "bar"
    }
  end
end

class Trip
  attr_reader :response

  def initialize(params = {})
    params.fetch(:origin)      { raise BadArgumentException, "I need an origin key." }
    params.fetch(:destination) { raise BadArgumentException, "I need a destination key." }
    params.fetch(:sensor)      { params[:sensor] = false }
    MapsAPIClient.get(params)
    @response = MapsAPIClient.response
  end

  def duration
    @response[:duration]
  end

  def distance
    @response[:distance]
  end

  def cost
    @response[:cost]
  end
end

  # --- change a wee bit ------ #
module BARTAPIClient
  BART_URL = "http://api.bart.gov/api/stn.aspx?cmd=stns&key=" + BART_API_KEY

  def bart_stations
    bart_uri = URI(BART_URL )

    bart_stns_xml = get_url(bart_uri)
    #puts bart_stns_xml
    @bart_stns = Nokogiri::XML(bart_stns_xml)

    @bart_stns_stn = @bart_stns.css("stations station")

    @bart_stns_stn.each do |stn|

      if stn.css("name").text.eql? @departure_stop
          @dep_stn_abbr = stn.css("abbr").text
      elsif stn.css("name").text.eql? @arrival_stop
          @arr_stn_abbr = stn.css("abbr").text
        #else
          #raise "Station #{stn} doesn't exist"
      end
    end
  end

  def bart_fare_query
    fare_uri = URI("http://api.bart.gov/api/sched.aspx?cmd=fare&orig=#{@dep_stn_abbr}&dest=#{@arr_stn_abbr}&key=#{BART_API_KEY}")
    fare_query = get_url(fare_uri)
    fare_xml = Nokogiri::XML(fare_query)
    @fare = fare_xml.css("trip fare").text
    puts "BART Fare #{@fare}"
  end
end
