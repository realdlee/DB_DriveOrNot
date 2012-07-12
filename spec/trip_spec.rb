require './lib/trip'

describe "Trip" do
  let(:trip) { Trip.new(:origin => "717 California St., San Francisco, CA", :destination => "3773 Mission St., San Francisco, CA") }

  context "#initialize" do
    it "raises error without origin and destination in options hash" do
      lambda { Trip.new(:foo => "bar") }.should raise_error BadArgumentException
    end

    it "needs a destination and origin parameters" do
      lambda { Trip.new(:destination => "bar", :origin => "sdgdfhSD") }.should_not raise_error BadArgumentException
    end
  end

  context "#json" do
    it "should deliver a JSON object" do
      trip.json_response.should be_instance_of Hash
    end
  end

  context "duration" do
    it "should give us a value for time traveled" do
      trip.duration.should be_instance_of Fixnum
    end
  end

  context "distance" do
    it "should give us a distance for length traveled" do
      trip.distance.should be_instance_of Fixnum
    end
  end

  context "travel cost" do
    it "should provide us with the total fare cost for BART transit" do
      trip.cost.should be_instance_of Fixnum
    end
  end
end