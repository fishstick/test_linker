Feature: Get info from TestLink
  As a TestLink API user
  I want to get info from the TestLink server
  So that I can use the info in reports and such

  Scenario Outline: Get a list of projects
    Given I have a TestLink server with API version <version>
    When I ask for the list of projects
    Then I get a list of projects

  Scenarios: Known API versions
    | version    |
    | 1.0 Beta 5 |
    | 1.0        |

  Scenario Outline: Get a list of test plans
    Given I have a TestLink server with API version <version>
    When I ask for the list of projects
    And I ask for the list of test plans
    Then I get a list of test plans

  Scenarios: Known API versions
    | version    |
    | 1.0 Beta 5 |
    | 1.0        |

  Scenario Outline: Get a list of test cases in a test plan
    Given I have a TestLink server with API version <version>
    And I have the list of projects
    And I know the name of a project
    And I have a list of test plans
    When I ask for the list of test cases in that test plan
    Then I get a list of test cases in that test plan

  Scenarios: Known API versions
    | version    |
    | 1.0 Beta 5 |
    | 1.0        |

  Scenario: Get a test project by its name
    Given I have a TestLink server with API version 1.0
    And I know the name of a project
    When I ask for that project by name
    Then I get that project

  Scenario: Get a test plan by its name
    Given I have a TestLink server with API version 1.0
    And I have the list of projects
    And I know the name of a project
    And I have a list of test plans
    And I know the name of a test plan in that project
    When I ask for that test plan by name
    Then I get that test plan

  Scenario: Get a test case by its ID
    Given I have a TestLink server with API version 1.0
    And I have the list of projects
    And I know the name of a project
    And I have a list of test plans
    And I know the ID of a test case in that project
    When I ask for that test case by ID
    Then I get that test case

