require 'rest-client'
require 'json'

class BadArgumentException < Exception; end;

class Trip
  def initialize(params = {})
    params.fetch(:origin)      { raise BadArgumentException, "I need an origin key." }
    params.fetch(:destination) { raise BadArgumentException, "I need a destination key." }
    params.fetch(:sensor)      { params[:sensor] = false }
    @params = params
    json_response
  end

  def duration
    response[:duration]
  end

  def distance
    response[:distance]
  end

  #private
    def json_response
      # json = eval(File.read('directions.txt'))
      json = RestClient.get "http://maps.googleapis.com/maps/api/directions/json", :params => @params
      @response = JSON.parse(json, :symbolize_names => true)
    end

    def response
      {:duration => @response[:routes][0][:legs][0][:duration][:value],
       :distance => @response[:routes][0][:legs][0][:disatnce][:value]}
    end

end

