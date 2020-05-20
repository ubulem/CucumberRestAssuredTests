@Products
@WIP
Feature: Operations with term deposit products
  In order to work with term deposit products
  I create and modify term deposit product

  Background: Log in as admin
    When I log in with username admin and password admin
    Then cloud should response with code 200

  Scenario: Create term deposit product with the same name
    Given there is the term deposit product with name Serenity Term Deposit Product or code STDP
    When I fill up term deposit fields such as accounts
      | principal | interestAccrual | interestExpense | interestWriteOff | earlyCloseFee |
      | 168       | 169             | 96              | 181              | 182           |
    And term deposit general parameters
      | name                     | Serenity Term Deposit Product |
      | code                     | STDP                          |
      | statusType               | ACTIVE                        |
      | interestAccrualFrequency | END_OF_MONTH                  |
      | amountMin                | 1000                          |
      | amountMax                | 1000000                       |
      | interestRateMin          | 5                             |
      | interestRateMax          | 15                            |
      | currencyId               | 1                             |
      | termAgreementMin         | 3                             |
      | termAgreementMax         | 24                            |
      | earlyCloseFeeRateMin     | 0                             |
      | earlyCloseFeeRateMax     | 10                            |
      | earlyCloseFeeFlatMin     | 0                             |
      | earlyCloseFeeFlatMax     | 1000                          |
    And create the term deposit product
    Then cloud should response with code 400
    And error code should be invalid
    And message should be Name is taken.

  Scenario: Create random active term deposit product
    When I fill up term deposit fields such as accounts
      | principal | interestAccrual | interestExpense | interestWriteOff | earlyCloseFee |
      | 168       | 169             | 96              | 181              | 182           |
    And term deposit general parameters
      | name                     | random       |
      | code                     | random       |
      | statusType               | ACTIVE       |
      | interestAccrualFrequency | END_OF_MONTH |
      | amountMin                | 1000         |
      | amountMax                | 1000000      |
      | interestRateMin          | 5            |
      | interestRateMax          | 15           |
      | currencyId               | 1            |
      | termAgreementMin         | 3            |
      | termAgreementMax         | 24           |
      | earlyCloseFeeRateMin     | 0            |
      | earlyCloseFeeRateMax     | 10           |
      | earlyCloseFeeFlatMin     | 0            |
      | earlyCloseFeeFlatMax     | 1000         |
    And create the term deposit product
    Then cloud should response with code 200
    And term deposit product should appear in the system

  Scenario: Create random inactive term deposit product
    When I fill up term deposit fields such as accounts
      | principal | interestAccrual | interestExpense | interestWriteOff | earlyCloseFee |
      | 168       | 169             | 96              | 181              | 182           |
    And term deposit general parameters
      | name                     | random       |
      | code                     | random       |
      | statusType               | INACTIVE     |
      | interestAccrualFrequency | END_OF_MONTH |
      | amountMin                | 1000         |
      | amountMax                | 1000000      |
      | interestRateMin          | 5            |
      | interestRateMax          | 15           |
      | currencyId               | 1            |
      | termAgreementMin         | 3            |
      | termAgreementMax         | 24           |
      | earlyCloseFeeRateMin     | 0            |
      | earlyCloseFeeRateMax     | 10           |
      | earlyCloseFeeFlatMin     | 0            |
      | earlyCloseFeeFlatMax     | 1000         |
    And create the term deposit product
    Then cloud should response with code 200
    And term deposit product shouldn't appear in the system
    When I click Show all button on TERM_DEPOSITS page
    Then term deposit product should appear in the list

  Scenario: Modify term deposit product
    Given there is the term deposit product with name Serenity Term Deposit Product or code STDP
    When I fill up term deposit fields such as accounts
      | principal | interestAccrual | interestExpense | interestWriteOff | earlyCloseFee |
      | 168       | 169             | 96              | 181              | 182           |
    And term deposit general parameters
      | name                     | Serenity Term Deposit Product |
      | code                     | STDP                          |
      | statusType               | ACTIVE                        |
      | interestAccrualFrequency | END_OF_MONTH                  |
      | amountMin                | 1000                          |
      | amountMax                | 1000000                       |
      | interestRateMin          | 5                             |
      | interestRateMax          | 15                            |
      | currencyId               | 1                             |
      | termAgreementMin         | 3                             |
      | termAgreementMax         | 24                            |
      | earlyCloseFeeRateMin     | 0                             |
      | earlyCloseFeeRateMax     | 10                            |
      | earlyCloseFeeFlatMin     | 0                             |
      | earlyCloseFeeFlatMax     | 1000                          |
    And modify the term deposit product
    Then cloud should response with code 200
    And term deposit product should appear in the system