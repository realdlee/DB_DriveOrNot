Given /^I am not yet using$/ do
  #pending # express the regexp above with the code you wish you had
end

When /^I start a drive$/ do
  dn = Drive::not.new("")
  dn.start('1234')
  pending # express the regexp above with the code you wish you had
end

Then /^I should see "(.*?)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end