@WIP
@Profiles
Feature: Operations with groups
  In order to work with clients
  I create and modify profiles
  e.g. persons, companies and groups

  Background: Log in as admin
    When I log in with username admin and password admin
    Then cloud should response with code 200

  Scenario Outline: Create two new random groups
    When I create new group with
      | 1 | <name> |
    Then cloud should response with code 200
    And request should be created
    And not appear in Maker/Checker tab

    Examples:
      | name   |
      | random |
      | random |

  Scenario: Update a group
    Given there is a group with id 7
    When I change group data with id 7 to
      | 1 | Alibaba |
    Then cloud should response with code 200
    And request should be created
    And not appear in Maker/Checker tab