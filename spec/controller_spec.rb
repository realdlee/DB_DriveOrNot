require '../lib/controller.rb'

describe "#initialize" do
  before :each do
      @cont = Controller.new("717 California Street, San Francisco", "600 Guerrero, San Francisco")
      a_fake_address = double('address')
      Address.stub(:new).and_return(a_fake_address)
  end

  it "should instantiate a Controller object" do
    @cont.should be_an_instance_of Controller
  end

  it "should receive two string arguments" do
     @cont.origin.should == "717 California Street, San Francisco"
     @cont.destination.should == "600 Guerrero, San Francisco"
   end

  it "should create @origin_address" do
    @cont.origin_address.should be_an_instance_of Address
  end

  it "should create @origin_address" do
    @cont.destination_address.should be_an_instance_of Address
  end

end

describe "#find_faster_option" do
  before :each do
    @cont = Controller.new("717 California Street, San Francisco", "600 Guerrero, San Francisco")
  end

  it "should have a method find_faster_option" do
    @cont.should respond_to(:find_faster_option)
  end

  # it "should return a trip object" do
  #   a_fake_driving_trip = double('drive trip')
  #   a_fake_bart_trip = double('bart trip')
  #   Trip.stub(:new).and_return(a_fake_driving_trip)
  #   Trip.stub(:new).and_return(a_fake_bart_trip)
  #   # @cont.find_faster_option
  #   a_fake_driving_trip.stub(:time).and_return(60)
  #   a_fake_bart_trip.stub(:time).and_return(90)
  #   puts a_fake_driving_trip.time
  #   # @cont.find_faster_option.should == a_fake_driving_trip
  #   puts @cont.find_faster_option
  # end
end
