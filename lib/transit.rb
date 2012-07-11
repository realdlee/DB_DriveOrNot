require 'net/http'

#require 'json'
require 'nokogiri'


module Driveornot
  BART_API_KEY = "5SHZ-XLUS-U9U5-MN24"

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
        search_query_google_xml
    end

    # def search_query_json
    #      #uri = URI("http://maps.googleapis.com/maps/api/directions/json?origin=Boston,MA&destination=Concord,MA&sensor=false")
    #      uri = URI("http://maps.googleapis.com/maps/api/directions/json?")
    #
    #      params = { :mode => 'transit', :origin => @origin, :destination => @destination, :departureTime => @departure_time, :sensor => false }
    #      uri.query = URI.encode_www_form(params)
    #      puts uri
    #      google_directions = Net::HTTP.get(uri)
    #      parsedJSON = JSON.parse(google_directions)
    #      puts parsedJSON
    #     end

    # def departure_time_valid?(@departure_time)
    #      unless @departure_time == /\d{1,2}\-\d{1,2}\-\d{4}\s\d{1,2}\:\d{1,2}/
    #        raise "Please enter in mm/dd/yyyy hh:mm format"
    #    end

     def search_query_google_xml

       # uri_transit = URI("http://maps.googleapis.com/maps/api/directions/xml?")
       #        uri_drive = URI("http://maps.googleapis.com/maps/api/directions/xml?")
       #        params_transit = { :mode => 'transit', :origin => @origin, :destination => @destination, :departureTime => @departure_time, :sensor => false }
       #        params_drive = { :mode => 'driving', :origin => @origin, :destination => @destination, :departureTime => @departure_time, :sensor => false }
       #        uri_transit.query = URI.encode_www_form(params_transit)
       #        uri_drive.query = URI.encode_www_form(params_drive)

       #puts uri_transit
       #        puts uri_drive.query

       # xml_transit = get_url(uri_transit)  #Google API call
       # xml_drive = get_url(uri_drive)

       xml_file = File.read('directions.xml')

       #puts xml_transit
       #puts xml_drive

       doc_transit = Nokogiri::XML(xml_file) #conversion to Nokogiri object
       # doc_drive = Nokogiri::XML(xml_drive)

       if doc_transit.css("status").text == 'OK'

           puts doc_transit_array = doc_transit.css("transit_details")

           doc_transit_array.each do |transit|
             if transit.css("agency name").text == "Bay Area Rapid Transit"
               puts @departure_stop  = transit.css("departure_stop name").text
               puts @arrival_stop = transit.css("arrival_stop name").text
             end
           end

           #puts doc
           transit_time = doc_transit.css("duration text").last.text
           transit_distance = doc_transit.css("distance text").last.text
           agency = doc_transit.css("leg step agency name").first.text
           puts agency

           puts "Transit Distance: #{transit_distance}, Transit Time: #{transit_time}"

            # drive_time = doc_drive.css("duration text").last.text
            # drive_distance = doc_drive.css("distance text").last.text
            # puts "Driving Distance: #{drive_distance}, Driving Time: #{drive_time}"

       else
         puts doc_transit.css("status").text
       end
       # if agency == "Bay Area Rapid Transit"
       #             puts @departure_stop = doc_transit.css("leg step transit_details departure_stop name").text
       #             puts @arrival_stop = doc_transit.css("leg step transit_details arrival_stop name").text
       #        end

       # @dep_stn_abr
       #        @arr_stn_abr

       bart_stations
       bart_fare_query


      end

      def bart_stations
        bart_uri = URI("http://api.bart.gov/api/stn.aspx?cmd=stns&key=" + BART_API_KEY)

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
        puts @dep_stn_abbr
        puts @arr_stn_abbr
      end

      def bart_fare_query
        fare_uri = URI("http://api.bart.gov/api/sched.aspx?cmd=fare&orig=#{@dep_stn_abbr}&dest=#{@arr_stn_abbr}&key=#{BART_API_KEY}")
        fare_query = get_url(fare_uri)
        fare_xml = Nokogiri::XML(fare_query)
        @fare = fare_xml.css("trip fare").text
        puts "BART Fare #{@fare}"

      end



      private

        def convert_to_minutes(text)
          (text.to_i / 60 ).ceil
        end

        def transcribe(location)
          location.gsub(" ", "+")
        end

        def get_url(uri)
          Net::HTTP.get(uri)
        end

        def station


        end

  end
end