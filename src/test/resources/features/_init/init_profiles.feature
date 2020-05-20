@Init
Feature: Initial profiles setup for further scenarios

  Background: Log in as admin to setup initial data
    When I log in with username Administrator and password admin
    Then cloud should response with code 200

  Scenario: Create a new person with certain data
    Given there is no profile with id 1
    When I create new person with
      | 1 | Sergey     |
      | 2 | Brin       |
      | 3 | 1973-08-21 |
    Then cloud should response with code 200
    And request should be created
    And not appear in Maker/Checker tab

  Scenario: Create a new person with certain data
    Given there is no profile with id 2
    When I create new person with
      | 1 | Larry      |
      | 2 | Page       |
      | 3 | 1973-03-26 |
    Then cloud should response with code 200
    And request should be created
    And not appear in Maker/Checker tab

  Scenario: Create a new person for savings
    Given there is no profile with id 3
    When I create new person with
      | 1 | Steve      |
      | 2 | Jobs       |
      | 3 | 1955-02-24 |
    Then cloud should response with code 200
    And request should be created
    And not appear in Maker/Checker tab

  Scenario: Create a new person for term deposits
    Given there is no profile with id 4
    When I create new person with
      | 1 | Bill       |
      | 2 | Gates      |
      | 3 | 1955-10-28 |
    Then cloud should response with code 200
    And request should be created
    And not appear in Maker/Checker tab

  Scenario: Create a new person for another savings
    Given there is no profile with id 5
    When I create new person with
      | 1 | Larry      |
      | 2 | Ellison    |
      | 3 | 1944-08-17 |
    Then cloud should response with code 200
    And request should be created
    And not appear in Maker/Checker tab

  Scenario: Create a new company with certain data
    Given there is no company with id 6
    When I create new company with
      | 4 | OpenCBS |
      | 5 | 3       |
    Then cloud should response with code 200
    And request should be created
    And not appear in Maker/Checker tab

  Scenario Outline: Add members to the company
    Given there is a company with id 6
    And profile with id <id> is not a member of company with id 6
    When I add the member with id <id> to the company with id 6
    Then cloud should response with code 200
    And member should appear in the company

    Examples:
      | id |
      | 1  |
      | 2  |

  Scenario: Create and approve a new group with certain name
    Given there is no group with id 7
    When I create new group with
      | 1 | Nirvana |
    Then cloud should response with code 200
    And request should be created
    And not appear in Maker/Checker tab

  Scenario Outline: Add members to the group
    Given there is a group with id 7
    And profile with id <id> is not a member of group with id 7
    When I add the member with id <id> to the group with id 7
    Then cloud should response with code 200
    And member should appear in the group

    Examples:
      | id |
      | 1  |
      | 2  |