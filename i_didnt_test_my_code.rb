require 'open-uri'
require 'nokogiri'

# doc = open("http://maps.googleapis.com/maps/api/directions/json?origin=1524+
# McAllister+San+Francisco&destination=717+California+San+Francisco&sensor=fal
# se")
class Google

  def initialize(start, destination)
    @start = start
    @destination = destination
    @transit_url = Nokogiri::XML(open("http://maps.googleapis.com/maps/api/directions/xml?origin=#{@start}&destination=#{@destination}&mode=transit&sensor=false"))
    @drive_url   = Nokogiri::XML(open("http://maps.googleapis.com/maps/api/directions/xml?origin=#{@start}&destination=#{@destination}&sensor=false"))
    @walking_dp_bart_url = Nokogiri::XML(open("http://maps.googleapis.com/maps/api/directions/xml?origin=#{@start}+bart+station&destination=#{@departure_bart_name}&mode=walking&sensor=false"))
    @walking_ar_bart_url = Nokogiri::XML(open("http://maps.googleapis.com/maps/api/directions/xml?origin=#{@arrival_bart_name}+bart+station&destination=#{@destination}&mode=walking&sensor=false"))
  end

  def calculate
    #driving calculations
  drive_distances = @drive_url.xpath('//distance/text')  #array
  drive_dist      = drive_distances[drive_distances.size-1].text
  drive_times     = @drive_url.xpath('//duration/text')   #array
  drive_time      = drive_times[drive_times.size-1].text

    #transit calculations
  transit_distances = @transit_url.xpath('//distance/text')
  transit_dist      = transit_distances[transit_distances.size-1].text
  transit_times     = @transit_url.xpath('//duration/text')
  transit_time      = transit_times[transit_times.size-1].text

  #   #finding bart station name
  # transit_fragment_xml = @transit_url.xpath('//transit_details')
  # transit_type = transit_fragment_xml.xpath('//transit_details/line/vehicle/type')
  # if transit_type == 'SUBWAY' #check the transit method is bart
  #   #get departure bart station name
  #   a = @transit_url.xpath('//transit_details/departure_stop/name')
  #   @departure_bart_name = a.text
  #   #get arrival bart stataion name
  #   b = @transit_url.xpath('//transit_details/arrival_stop/name')
  #   @arrival_bart_name = b.text
  # end

    #working calculations
  walking_dp_distances = @walking_dp_bart_url.xpath('//distance/text')
  dp_walking_distances = walking_dp_distances.last.text
  walking_ar_distances = @walking_ar_bart_url.xpath('//duration/text')
  ar_walking_distances = walking_ar_distances.last.text


  puts "Driving will take you #{drive_time} to make the #{drive_dist} trip."
  puts "Taking public transport will take you #{transit_time} to make the #{transit_dist} trip."
  # puts "if you want to using bart then you hva to walk #{dp_walking_distances} miles from #{@start} to #{@departure_bart_name} and #{ar_walking_distances} miles from #{@destination} to #{@arrival_bart_name}"
  end
end

@example = Google.new("600+guerrero+st+sf", "717+California+Street+San+Francisco")
@example.calculate


# doc = Nokogiri::HTML(open('http://google.com/search?q=tenderlove'))

# doc.css('h3.r > a.l').each do |link|
#   puts link.content
# end
# doc.xpath('//distance/text').each do |link|
# puts link.content
# end
