class Trip
  def weather_info
  end

  def walking_info
  end

  def fare_info
  end

  def gas_info
  end

  def transit_time_info
  end

  def driving_time_info
  end
end

class Calculator
  #BUG BUG - get rid of the attr_accessor for weather
  attr_accessor :orig_address, :dest_address, :weather, :walking, :fare, :gas, :transit_time, :driving_time

  def initialize(orig_address, dest_address)
    @orig_address = orig_address
    @dest_address = dest_address
  end

  def create_trip
    # @send_trip = Trip.new(@orig_address, @dest_address)
  end

  def get_info
    @trip = Trip.new
    @weather      = @trip.weather_info
    @walking      = @trip.walking_info
    @fare         = @trip.fare_info
    @gas          = @trip.gas_info
    @transit_time = @trip.transit_time_info
    @driving_time = @trip.driving_time_info
    # @weather = Trip.iwillgiveyouweathermethod
    # @walkingdistance = Trip.iwillgiveyouwalkingdistancemethod
    # @fare = Trip.iwillgiveyoufaremethod
    # @gasfee = Trip.iwillgiveyougasfeemethod
    # @transittime = Trip.iwillgiveyoutrasittimemethod
    # @drivingtime = Trip.iwillgiveyoudrivingtimemethod
    #BUG BUG - add a return value down here and update the tests to evaluate the return value
  end

  def result

  end

end