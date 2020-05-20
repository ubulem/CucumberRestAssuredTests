@ImpactFinance
@Config
Feature: Operations with other fees
  In order to work with other fees
  I create and edit them via configuration

  Background: Log in as admin to setup initial data
    When I log in with username admin and password admin
    Then cloud should response with code 200

  Scenario: Create a specific other fee
    Given there is no other fee with name Some Fee
    When I create other fee
      | name     | description                               | chargeAccountId | incomeAccountId | expenseAccountId |
      | Some Fee | Some Fee for test early partial repayment | 61              | 152             | 153              |

    Then cloud should response with code 200

  Scenario: Create an other fee with existing name
    Given there is an other fee with name Some Fee
    When I create other fee
      | name     | description                               | chargeAccountId | incomeAccountId | expenseAccountId |
      | Some Fee | Some Fee for test early partial repayment | 61              | 152             | 153              |
    Then cloud should response with code 400
    And error code should be invalid
    And message should be The name of other fee is already taken
