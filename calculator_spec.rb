# require 'simplecov'
require 'rspec'
require './calculator.rb'
# SimpleCov.start

describe "#initialize" do
  before :each do
    @test = Calculator.new("717 california st,sf", "25 duboce ave,sf")
  end

  it "gets the origin and destination addresses from interface" do
    @test.orig_address.should == "717 california st,sf"
    @test.dest_address.should == "25 duboce ave,sf"
  end
end

describe "#create_trip" do
  before :each do
    @test = Calculator.new("717 california st,sf", "25 duboce ave,sf")
    @test.create_trip
  end

  it "sends infomation to trip class" do
    @test.should respond_to(:create_trip)
  end
end

describe "#get_info" do
  before :each do
    @test = Calculator.new("717 california st,sf", "25 duboce ave,sf")
    @test.get_info
  end

  it "sends infomation to trip class" do
    @test.should respond_to(:get_info)
  end
end

describe "#result" do
  before :each do
    @test = Calculator.new("717 california st,sf", "25 duboce ave,sf")

  end

  it "receives weather variable" do
    a_fake_trip = double('trip')
    Trip.stub(:new).and_return(a_fake_trip)
    a_fake_trip.stub(:weather_info).and_return('its rainy')
    @test.get_info
    @test.weather.should == "its rainy"
  end
end

