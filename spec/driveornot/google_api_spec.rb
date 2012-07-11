require 'spec_helper'

module Driveornot

  describe "Driveornot::GoogleAPI" do
    let(:google) { Driveornot::GoogleAPI.new }

    context "#initialization" do
      it "should return a Google_API object" do
        google.should be_an_instance_of Driveornot::GoogleAPI
      end
    end
  end
end