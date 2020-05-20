@WIP
@Config
Feature: Operations with branches
  In order to work with branches
  I create and edit them via configuration

  Background: Log in as admin to setup initial data
    When I log in with username admin and password admin
    Then cloud should response with code 200

  Scenario: Create a random branch
    When I create branch
      | name | random |
      | code | random |
    Then cloud should response with code 200

  Scenario: Create a branch with existing name
    Given there is a branch with name Bishkek
    When I create branch
      | name | Bishkek |
      | code | 312     |
    Then cloud should response with code 400
    And error code should be invalid
    And message should be Branch name already taken.

  Scenario: Modify a branch
    Given there is a branch with name Bishkek
    And there is no branch with name Osh
    When I change branch Bishkek to
      | name | Osh |
      | code | 123 |
    Then cloud should response with code 200
    And branch name should be changed to Osh