@MakerChecker
@Products
@WIP
Feature: Check Maker-checker system permissions for term deposit
  There are separate permissions for every entity under the system
  Maker can create or delete his own requests as well as
  checker can approve or reject only his ones

  Background: Log in as admin
    When I log in with username admin and password admin
    Then cloud should response with code 200

  Scenario: Create and approve random term deposit product
    When I log in with username maker and password @penCBS2019
    And I fill up term deposit fields such as accounts
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
    And request should be created
    And I log in with username checker and password @penCBS2019
    And approve it
    Then cloud should response with code 200
    And term deposit product should appear in the system

  Scenario: Create and disapprove term deposit product
    Given there is no term deposit product with name TermDepositToDelete or code TDTD
    When I log in with username maker and password @penCBS2019
    And I fill up term deposit fields such as accounts
      | principal | interestAccrual | interestExpense | interestWriteOff | earlyCloseFee |
      | 168       | 169             | 96              | 181              | 182           |
    And term deposit general parameters
      | name                     | TermDepositToDelete |
      | code                     | TDD                 |
      | statusType               | ACTIVE              |
      | interestAccrualFrequency | END_OF_MONTH        |
      | amountMin                | 1000                |
      | amountMax                | 1000000             |
      | interestRateMin          | 5                   |
      | interestRateMax          | 15                  |
      | currencyId               | 1                   |
      | termAgreementMin         | 3                   |
      | termAgreementMax         | 24                  |
      | earlyCloseFeeRateMin     | 0                   |
      | earlyCloseFeeRateMax     | 10                  |
      | earlyCloseFeeFlatMin     | 0                   |
      | earlyCloseFeeFlatMax     | 1000                |
    And create the term deposit product
    Then cloud should response with code 200
    And request should be created
    When I log in with username checker and password @penCBS2019
    And disapprove it
    Then cloud should response with code 200
    And term deposit product shouldn't appear in the system

  Scenario: Modify and approve term deposit product
    Given there is the term deposit product with name Serenity Term Deposit Product or code STDP
    When I log in with username maker and password @penCBS2019
    And I fill up term deposit fields such as accounts
      | principal | interestAccrual | interestExpense | interestWriteOff | earlyCloseFee |
      | 168       | 169             | 96              | 181              | 182           |
    And term deposit general parameters
      | name                     | Serenity Term Deposit Product |
      | code                     | STDP                          |
      | statusType               | ACTIVE                        |
      | interestAccrualFrequency | END_OF_MONTH                  |
      | amountMin                | 100                           |
      | amountMax                | 2000000                       |
      | interestRateMin          | 2                             |
      | interestRateMax          | 20                            |
      | currencyId               | 1                             |
      | termAgreementMin         | 3                             |
      | termAgreementMax         | 24                            |
      | earlyCloseFeeRateMin     | 0                             |
      | earlyCloseFeeRateMax     | 10                            |
      | earlyCloseFeeFlatMin     | 0                             |
      | earlyCloseFeeFlatMax     | 1000                          |
    And modify the term deposit product
    Then cloud should response with code 200
    And request should be created

    And modify the term deposit product
    Then cloud should response with code 500
    And error code should be internal_error
    And message should be This object has already active request!

    When I log in with username checker and password @penCBS2019
    And approve it
    Then cloud should response with code 200
    And term deposit product should appear in the system

  Scenario: Create a pending request of a term deposit product
    When I log in with username maker and password @penCBS2019
    And I fill up term deposit fields such as accounts
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
    And request should be created
    And appear in Maker/Checker tab
    And term deposit product shouldn't appear in the system