class Trip
  def weather_info
  end
end

class Calculator
  attr_accessor :orig_address, :dest_address, :weather

  def initialize(orig_address, dest_address)
    @orig_address = orig_address
    @dest_address = dest_address
  end

  def create_trip
    # @send_trip = Trip.new(@orig_address, @dest_address)
  end

  def get_info
    @trip = Trip.new
    @weather = @trip.weather_info
    # @weather = Trip.iwillgiveyouweathermethod
    # @walkingdistance = Trip.iwillgiveyouwalkingdistancemethod
    # @fare = Trip.iwillgiveyoufaremethod
    # @gasfee = Trip.iwillgiveyougasfeemethod
    # @transittime = Trip.iwillgiveyoutrasittimemethod
    # @drivingtime = Trip.iwillgiveyoudrivingtimemethod
  end

  def result

  end

end