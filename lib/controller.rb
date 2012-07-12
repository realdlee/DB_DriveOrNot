class Address
  def initialize(address)
  end
end
class Trip
  def initialize
  end
end

class Controller
  attr_accessor :origin_address, :destination_address, :origin, :destination

  def initialize origin, destination
    @origin              = origin
    @destination         = destination
    @origin_address      = Address.new(origin)
    @destination_address = Address.new(destination)
  end

  def find_faster_option
  #    MapsAPIClient.get(:origin => ..., :destination => ...)
    a = [:bart, :drive].map do |mode|
      Trip.new :origin_address      => origin_address,
               :destination_address => destination_address,
               :mode                => mode
    end
    a.min_by { |trip| trip.time }
    return a[2]
  end
end

