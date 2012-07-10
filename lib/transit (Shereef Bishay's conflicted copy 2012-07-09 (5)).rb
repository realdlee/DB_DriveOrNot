require 'net/http'
require 'json'

module Driveornot


  class Transit

    def initialize(output)
      @output = output
    end

    def start
        @output.puts "Welcome to Drive Or Not!"
        @output.puts "When are you leaving? Please enter in mm/dd/yy hh:mm format"
        #@output.gets(Time.now)
        @departure_time = gets.chomp
        @output.puts "Where are you coming from?"
        @origin = gets.chomp
        #@output.gets("717a California Street CA 94108")
        @output.puts "Where are you going to?"
        @destination = gets.chomp
        #@output.gets("3773 Mission Street CA 94110")
        search_query
    end

    def search_query
     #uri = URI("http://maps.googleapis.com/maps/api/directions/json?origin=Boston,MA&destination=Concord,MA&sensor=false")
     uri = URI("http://maps.googleapis.com/maps/api/directions/json?")
     params = { :origin => @origin, :destination => @destination, :sensor => false }
     uri.query = URI.encode_www_form(params)
     puts uri
     google_directions = Net::HTTP.get(uri)
     parsedJSON = JSON.parse(google_directions)
     puts parsedJSON

    end

    # def departure_time_valid?(@departure_time)
    #      unless @departure_time == /\d{1,2}\-\d{1,2}\-\d{4}\s\d{1,2}\:\d{1,2}/
    #        raise "Please enter in mm/dd/yyyy hh:mm format"
    #    end

  end
end