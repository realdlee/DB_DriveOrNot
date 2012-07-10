require 'simplecov'
require 'rspec'
require 'sqlite3'
SimpleCov.start


describe "#add" do
  it "adds an address to the address list" do
    address = Address.new('717 California Street, San Francisco, CA 94108', 'home')
    list.add address
    list.address[0].should eq "717 California Street, San Francisco, CA 94108"
    list.address[1].should eq "home"
  end

end

# describe "#save" do

  # @address = Address.new(:street_address => '717 California Street')
  #
  #  it "should have an address object" do
  #  @
  #  it "should check to see if the file exists"
  #  it "should have a table for addresses"
  #  it "should have the proper headings (street address, zipcode, name, etc.)"
  #  it "should raise an error if the address is incomplete"
  #  it "should validate the input to ensure correct spelling"
  #
  #  end
