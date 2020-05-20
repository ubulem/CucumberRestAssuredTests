@Init
Feature: Initial reference data setup for further scenarios

  Background: Log in as admin to setup initial data
    When I log in with username Administrator and password admin
    Then cloud should response with code 200

  @WIP
  Scenario: Create location Kyrgyzstan
    Given there is no location with name Kyrgyzstan
    When I create location Kyrgyzstan
    Then cloud should response with code 200

  @WIP
  Scenario: Create sub location Bishkek
    Given there is no sub-location with name Bishkek
    And there is a location with name Kyrgyzstan
    When I create sub location Bishkek as child of Kyrgyzstan
    Then cloud should response with code 200

  @WIP
  Scenario: Create branch with certain data
    Given there is no branch with name Bishkek
    When I create branch
      | name | Bishkek |
      | code | 312     |
    Then cloud should response with code 200

  Scenario: Create two committees for different ranges
    Given there are no ranges bigger than 1000000
    When I create range with amount 1000000 and users with roles admin should be included into committee
    Then cloud should response with code 200
    And committees should be created with amount 1000000