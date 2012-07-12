require 'rest-client'
require 'json'
require 'nokogiri'
require 'crack'

class BadArgumentException < Exception; end;

BART_API_KEY = "5SHZ-XLUS-U9U5-MN24"

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

  # private
  def json_response
    # json = eval(File.read('directions.txt'))
    json_google = RestClient.get "http://maps.googleapis.com/maps/api/directions/json", :params => @params
    @response = JSON.parse(json_google, :symbolize_names => true)
  end

  def response
    {:duration => @response[:routes][0][:legs][0][:duration][:value],
     :distance => @response[:routes][0][:legs][0][:distance][:value]
    }
  end



  def xml_response
    xml_google = RestClient.get "http://maps.googleapis.com/maps/api/directions/xml", :params => @params

    puts noko_xml = Nokogiri::XML(xml_google) #conversion to Nokogiri object

    if noko_xml.css("status").text == 'OK'
      noko_xml_array = noko_xml.css("transit_details")

      noko_xml_array.each do |transit|
        if transit.css("agency name").text == "Bay Area Rapid Transit"
          @departure_stop  = transit.css("departure_stop name").text
          @arrival_stop = transit.css("arrival_stop name").text
        end
      end

    transit_time = noko_xml.css("duration text").last.text
    transit_distance = noko_xml.css("distance text").last.text
    agency = noko_xml.css("leg step agency name").first.text

    puts "Transit Distance: #{transit_distance}, Transit Time: #{transit_time}"

    else
      puts noko_xml.css("status").text
    end

    bart_stations
    bart_fare_query
  end

  def bart_stations
    bart_uri = URI("http://api.bart.gov/api/stn.aspx?cmd=stns&key=" + BART_API_KEY)

    bart_stations_xml = get_url(bart_uri)

    @bart_stns = Nokogiri::XML(bart_stations_xml)

    @bart_stns_stn = @bart_stns.css("stations station")

    @bart_stns_stn.each do |stn|
        if stn.css("name").text.eql? @departure_stop
            @dep_stn_abbr = stn.css("abbr").text
        elsif stn.css("name").text.eql? @arrival_stop
            @arr_stn_abbr = stn.css("abbr").text
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

trip = Trip.new(:origin => "717 California St., San Francisco, CA", :destination => "3773 Mission St., San Francisco, CA", :mode => "transit")
trip.xml_response