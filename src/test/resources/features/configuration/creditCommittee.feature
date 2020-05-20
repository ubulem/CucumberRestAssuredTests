@WIP
@Config
Feature: Manage credit committee
  In order to approve loan applications
  I create different committees and respective ranges

  Background: Log in as admin
    When I log in with username admin and password admin
    Then cloud should response with code 200

  Scenario Outline: Create two committees for different ranges
    Given there are no ranges bigger than <amount>
    When I create range with amount <amount> and users with roles <roleIds> should be included into committee
    Then cloud should response with code 200
    And committees should be created with amount <amount>
    Examples:
      | amount   | roleIds         |
      | 2000000  | admin           |
      | 10000000 | admin,Test Role |

  Scenario Outline: Create invalid committee ranges
    Given there are the ranges bigger than <amount>
    When I create range with amount <amount> and users with roles <roleIds> should be included into committee
    Then cloud should response with code 400
    And error code should be invalid
    And message should be <message>
    Examples:
      | amount | roleIds         | message                                |
      | -10    | admin           | Amount should be greater than zero.    |
      | 1000   | admin,Test Role | Amount should be greater than 10000000. |