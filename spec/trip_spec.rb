# David's attempt at 11pm

require '../lib/trip.rb'
include DriveOrNot
require 'simplecov'
require 'rspec'
SimpleCov.start

describe "#initialize" do
  it "should receive a starting address and a destination address" do
    @sample_trip = Trip.new("717 California Street, San Francisco, CA 94108", "1524 McAllister Street, San Francisco, CA")
    @sample_trip.should be_an_instance_of Trip
  end
end

describe "Google Maps API" do
  it "should calculate the travel time between the two addresses" do
  end
  
end


end
