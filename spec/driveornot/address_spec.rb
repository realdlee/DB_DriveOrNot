require 'simplecov'
require 'rspec'
require 'sqlite3'
require '../../lib/address.rb'
SimpleCov.start

describe "initialized datebase" do
  before(:all) do
    @address = Address.new
    @address.save_db('717 California Street, San Francisco, CA 94108', 'home')
  end

  # it "adds an address to the address list" do
  #   @address.location.should == "717 California Street, San Francisco, CA 94108"
  #   @address.tag.should == "home"
  #   # list.location should eq "717 California Street, San Francisco, CA 94108"
  #   # list.tag.should eq "home"
  # end

  it "creates a database if a database does not exist already" do
    check = File.exists? "nonexistent_file.db"
    check.should eq false
    check2 = File.exists? 'drive_or_not_test.db'
    check2.should eq true
    # File.should_receive(:open).with('drive_or_not_test.db', 'r').and_yield(false)
  end

  it "adds and saves the address and tag to the database" do
      result = @address.db.execute <<-SQL
        SELECT * FROM addresses
      SQL
      result.should == ["1", "717 California Street, San Francisco, CA 94108", "home"]

    end

  # it "adds an address to the database" do
  #
  # end

end

  #  it "should have a table for addresses"
