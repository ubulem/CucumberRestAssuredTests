@WIP
@Profiles
Feature: Operations with companies
  In order to work with clients
  I create and modify profiles
  e.g. persons, companies and groups

  Background: Log in as admin
    When I log in with username admin and password admin
    Then cloud should response with code 200

  Scenario Outline: Create two new random companies
    When I create new company with
      | 4 | <name>     |
      | 5 | <business> |
    Then cloud should response with code 200
    And request should be created
    And not appear in Maker/Checker tab

    Examples:
      | name   | business |
      | random | random   |
      | random | random   |

  Scenario: Update a company
    Given there is a company with id 6
    When I change company data with id 6 to
      | 4 | Google |
      | 5 | 3       |
    Then cloud should response with code 200
    And request should be created
    And not appear in Maker/Checker tab