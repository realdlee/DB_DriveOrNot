require 'spec_helper.rb'

module Driveornot

  describe "Interface" do

    let(:output) { double('output').as_null_object } ##creates a mock object called output that mocks STDOUT
    let(:transit) { Driveornot::Interface.new(output) } ##like a "before each do" to create a class Transit object
    #Time.stub(:now).and_return('2012-07-05 11:34:36 -0700')

    context "#display options" do
      it "should display welcome message" do
        output.should_receive(:puts).with("Welcome to Drive Or Not!")
        transit.start
      end

      it "should ask where the trip starts"   do
       output.should_receive(:puts).with("Welcome to Drive Or Not!")
       output.should_receive(:puts).with("Where are you coming from?")
       transit.start
     end

      it "should ask where the trip ends" do
        output.should_receive(:puts).with("Welcome to Drive Or Not!")
        output.should_receive(:puts).with("Where are you coming from?")
        output.should_receive(:puts).with("Where are you going to?")
        transit.start
      end
     end
   #
   # context "#data validation" do
   #   it "should have a departure time of a datetime format" do
   #     transit.departure_time.should be(/\d{1,2}\-\d{1,2}\-\d{4}\s\d{1,2}\:\d{1,2}/)
   #   end
   # end
  end
end