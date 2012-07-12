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
  attr_reader :maps_response, :BART_response

  def initialize(params = {})
    params.fetch(:origin)      { raise BadArgumentException, "I need an origin key." }
    params.fetch(:destination) { raise BadArgumentException, "I need a destination key." }
    params.fetch(:sensor)      { params[:sensor] = false }
    MapsAPIClient.get(params)
    @maps_response = MapsAPIClient.response
  end

  def duration
    @maps_response[:duration]
  end

  def distance
    @maps_response[:distance]
  end
end

