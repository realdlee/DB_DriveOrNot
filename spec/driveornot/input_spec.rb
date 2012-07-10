require 'spec_helper'


module Driveornot

  describe "Transit" do

    let(:output) { double('output').as_null_object } ##creates a mock object called output that mocks STDOUT
    let(:transit) { Driveornot::Transit.new(output) } ##like a "before each do" to create a class Transit object
    #Time.stub(:now).and_return('2012-07-05 11:34:36 -0700')

    context "#display options" do
      it "should display welcome message" do
        output.should_receive(:puts).with("Welcome to Drive Or Not!")
        transit.start
      end

      it "should ask when the trip starts" do
        output.should_receive(:puts).with("Welcome to Drive Or Not!")
        output.should_receive(:puts).with("When are you leaving?")
        transit.start
      end

      it "should get when the trip starts" do
        output.should_receive(:puts).with("Welcome to Drive Or Not!")
        output.should_receive(:puts).with("When are you leaving?")
        output.should_receive(:gets).with(Time.now + 0.001)
        transit.start
      end



      it "should ask where the trip starts" do
        output.should_receive(:puts).with("Welcome to Drive Or Not!")
        #output.should_receive(:puts).with("When are you leaving?")
        #output.should_receive(:gets).with(Time.now + 0.001)
        output.should_receive(:puts).with("Where are you coming from?")
        #output.should_receive(:gets).with("717a California Street CA 94108")
        output.should_receive("717a California Street CA 94108")
        transit.start
      end

      it "should ask where the trip ends" do
        output.should_receive(:puts).with("Welcome to Drive Or Not!")
        #output.should_receive(:puts).with("When are you leaving?")
        #output.should_receive(:puts).with("Where are you coming from?")
        output.should_receive(:puts).with("Where are you going to?")
        output.should_receive(:gets).with("3773 Mission Street CA 94110")
        transit.start
      end
    end

   context "#data validation" do
     it "should have a departure time of a datetime format" do
       transit.departure_time.should be(/\d{1,2}\-\d{1,2}\-\d{4}\s\d{1,2}\:\d{1,2}/)
     end
   end
  end
end