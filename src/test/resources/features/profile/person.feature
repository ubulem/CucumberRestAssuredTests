@WIP
@Profiles
Feature: Operations with persons
  In order to work with clients
  I create and modify profiles
  e.g. persons, companies and groups

  Background: Log in as admin
    When I log in with username admin and password admin
    Then cloud should response with code 200

  Scenario Outline: Create five new random persons
    When I create new person with
      | 1 | <firstName> |
      | 2 | <lastName>  |
      | 3 | 1979-02-25  |
    Then cloud should response with code 200
    And request should be created
    And not appear in Maker/Checker tab

    Examples:
      | firstName | lastName |
      | random    | random   |
      | random    | random   |

  Scenario: Update a person
    Given there is a profile with id 1
    When I change person data with id 1 to
      | 1 | Jeff       |
      | 2 | Bezos      |
      | 3 | 1964-01-12 |
    Then cloud should response with code 200
    And request should be created
    And not appear in Maker/Checker tab