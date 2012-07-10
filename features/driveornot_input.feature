Feature: driveornot starts input

  As a user of driveornot
  I want to start a trip
  So that I can enter the details

  Scenario: start driveornot
    Given I am not yet using
    When I start a drive_or_not
    Then I should see "Welcome to Drive Or Not!"
    And I should see "Enter departure date & time:"
    And I should see "Enter From location:"
    And I should see "Enter To location:"
