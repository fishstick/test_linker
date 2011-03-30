Feature: Get info from TestLink
  As a TestLink API user
  I want to get info from the TestLink server
  So that I can use the info in reports and such

  Scenario: Get a list of projects
    Given I have a TestLink server with API version:
      | version |
      | 1.0 Beta 5 |
      | 1.0         |
    When I ask for the list of projects
    Then I get a list of projects


