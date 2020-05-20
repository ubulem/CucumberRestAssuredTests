@WIP
@Config
Feature: Operations with roles
  In order to work with roles
  I create a role with certain permissions
  and verify it works as intended

  Background: Log in as admin to setup initial data
    When I log in with username admin and password admin
    Then cloud should response with code 200

  Scenario: Create a random active role
    When I create role with name random and status ACTIVE and permissions
      | DAY_CLOSURE | TRIAL_BALANCES | CHART_OF_ACCOUNTS | REPORTS | CONFIGURATIONS | TASKS_MANAGEMENT | GENERAL_LEDGER | SETTING |
    Then cloud should response with code 200
    And request should be created
    And not appear in Maker/Checker tab
    And role random should appear in the system

  Scenario: Create a random inactive role
    When I create role with name random and status INACTIVE and permissions
      | DAY_CLOSURE | TRIAL_BALANCES | CHART_OF_ACCOUNTS | REPORTS | CONFIGURATIONS | TASKS_MANAGEMENT | GENERAL_LEDGER | SETTING |
    Then cloud should response with code 200
    And request should be created
    And not appear in Maker/Checker tab
    And role random shouldn't appear in the system
    When I click Show all button on ROLES page
    Then role random should appear in the list

  Scenario: Create a role with existing name
    When I create role with name admin and status ACTIVE and permissions
      | DAY_CLOSURE | TRIAL_BALANCES | CHART_OF_ACCOUNTS | REPORTS | CONFIGURATIONS | TASKS_MANAGEMENT | GENERAL_LEDGER | SETTING |
    Then cloud should response with code 400
    And error code should be invalid
    And message should be Role already exist.

  Scenario: Modify a role
    Given there is a role with name Test Role
    When I modify role with name Test Role with the following set of permissions
      | CONFIGURATIONS |
    Then cloud should response with code 200
    And request should be created
    And not appear in Maker/Checker tab