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
    a_fake_trip = double('trip')
    Trip.stub(:new).and_return(a_fake_trip)
    a_fake_trip.stub(:weather_info).and_return('its rainy')
    a_fake_trip.stub(:walking_info).and_return('3miles')
    a_fake_trip.stub(:fare_info).and_return('$3.00')
    @test.get_info
  end

  it "receives weather variable" do
    @test.weather.should == "its rainy"
  end

  it "receives walking distance variable" do
    @test.walking.should == "3miles"
  end

  it "receives walking distance variable" do
     @test.fare.should == "$3.00"
  end
end

