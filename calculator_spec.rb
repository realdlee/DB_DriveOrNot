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

describe "#sending_info" do
  before :each do
    @test = Calculator.new("717 california st,sf", "25 duboce ave,sf")
    @test.sending_info
  end

  it "sends infomation to trip class" do
    @test.should respond_to(:sending_info)
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

  # describe "#result" do
  #   before :each do
  #     @test = Calculator.new("717 california st,sf", "25 duboce ave,sf")
  #     @test.result
  #   end
  #
  #   it "calculates " do
  #     @test.should respond_to(:get_info)
  #   end

end

