class Calculator
  attr_accessor :orig_address, :dest_address

  def initialize(orig_address, dest_address)
    @orig_address = orig_address
    @dest_address = dest_address
  end

  def sending_info
    # @send_trip = Trip.new(@orig_address, @dest_address)
  end

  def get_info
    # @get_info = Trip.iwillgiveyouweathermethod
    # @get_info = Trip.iwillgiveyoufaremethod
    # @get_info = Trip.iwillgiveyougasmethod
    # @get_info = Trip.iwillgiveyoutimemethod
    # @get_info = Trip.iwillgiveyouweathermethod
  end

end