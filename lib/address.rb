require 'active_record'
require './db/database_setup.rb'

class Address < ActiveRecord::Base
  validates_presence_of :full_address
end

# describe Address do
#   it "requires a full_address" do
#     subject.full_address = ""
#     subject.should have(1).error_on(:full_address)
#     subject.full_address = "717 California Street"
#     subject.should have(:no).error_on(:full_address)
#   end
# end