@MakerChecker
@Products
@WIP
Feature: Check Maker-checker system permissions for savings
  There are separate permissions for every entity under the system
  Maker can create or delete his own requests as well as
  checker can approve or reject only his ones

  Background: Log in as admin
    When I log in with username admin and password admin
    Then cloud should response with code 200

  Scenario: Create and approve random saving product
    When I log in with username maker and password @penCBS2019
    And I fill up saving fields such as accounts
      | saving | interest | interestExpense | depositFee | depositFeeIncome | withdrawalFee | withdrawalFeeIncome | managementFee | managementFeeIncome | entryFee | entryFeeIncome | closeFee | closeFeeIncome |
      | 163    | 164      | 165             | 173        | 174              | 173           | 174                 | 175           | 176                 | 178      | 177            | 180      | 179            |
    And saving general parameters
      | name                     | random       |
      | interestAccrualFrequency | DAILY        |
      | postingFrequency         | END_OF_MONTH |
      | capitalized              | true         |
      | code                     | random       |
      | statusType               | ACTIVE       |
      | initialAmountMin         | 0            |
      | initialAmountMax         | 1000000      |
      | interestRateMin          | 2            |
      | interestRateMax          | 10           |
      | currencyId               | 1            |
      | minBalance               | 1000         |
      | depositAmountMin         | 1000         |
      | depositAmountMax         | 100000       |
      | depositFeeRateMin        | 0            |
      | depositFeeRateMax        | 10           |
      | depositFeeFlatMin        | 0            |
      | depositFeeFlatMax        | 1000         |
      | withdrawalAmountMin      | 5000         |
      | withdrawalAmountMax      | 50000        |
      | withdrawalFeeRateMin     | 0            |
      | withdrawalFeeRateMax     | 10           |
      | withdrawalFeeFlatMin     | 0            |
      | withdrawalFeeFlatMax     | 1000         |
      | managementFeeRateMin     | 0            |
      | managementFeeRateMax     | 10           |
      | managementFeeFlatMin     | 0            |
      | managementFeeFlatMax     | 1000         |
      | managementFeeFrequency   | END_OF_MONTH |
      | entryFeeRateMin          | 0            |
      | entryFeeRateMax          | 10           |
      | entryFeeFlatMin          | 0            |
      | entryFeeFlatMax          | 1000         |
      | closeFeeRateMin          | 0            |
      | closeFeeRateMax          | 10           |
      | closeFeeFlatMin          | 0            |
      | closeFeeFlatMax          | 1000         |
    And create the saving product
    Then cloud should response with code 200
    And request should be created
    And I log in with username checker and password @penCBS2019
    And approve it
    Then cloud should response with code 200
    And saving product should appear in the system

  Scenario: Create and disapprove saving product
    Given there is no saving product with name SavingToDelete or code STD
    When I log in with username maker and password @penCBS2019
    And I fill up saving fields such as accounts
      | saving | interest | interestExpense | depositFee | depositFeeIncome | withdrawalFee | withdrawalFeeIncome | managementFee | managementFeeIncome | entryFee | entryFeeIncome | closeFee | closeFeeIncome |
      | 163    | 164      | 165             | 173        | 174              | 173           | 174                 | 175           | 176                 | 178      | 177            | 180      | 179            |
    And saving general parameters
      | name                     | SavingToDelete |
      | interestAccrualFrequency | DAILY          |
      | postingFrequency         | END_OF_MONTH   |
      | capitalized              | true           |
      | code                     | STD            |
      | statusType               | ACTIVE         |
      | initialAmountMin         | 0              |
      | initialAmountMax         | 1000000        |
      | interestRateMin          | 2              |
      | interestRateMax          | 10             |
      | currencyId               | 1              |
      | minBalance               | 1000           |
      | depositAmountMin         | 1000           |
      | depositAmountMax         | 100000         |
      | depositFeeRateMin        | 0              |
      | depositFeeRateMax        | 10             |
      | depositFeeFlatMin        | 0              |
      | depositFeeFlatMax        | 1000           |
      | withdrawalAmountMin      | 5000           |
      | withdrawalAmountMax      | 50000          |
      | withdrawalFeeRateMin     | 0              |
      | withdrawalFeeRateMax     | 10             |
      | withdrawalFeeFlatMin     | 0              |
      | withdrawalFeeFlatMax     | 1000           |
      | managementFeeRateMin     | 0              |
      | managementFeeRateMax     | 10             |
      | managementFeeFlatMin     | 0              |
      | managementFeeFlatMax     | 1000           |
      | managementFeeFrequency   | END_OF_MONTH   |
      | entryFeeRateMin          | 0              |
      | entryFeeRateMax          | 10             |
      | entryFeeFlatMin          | 0              |
      | entryFeeFlatMax          | 1000           |
      | closeFeeRateMin          | 0              |
      | closeFeeRateMax          | 10             |
      | closeFeeFlatMin          | 0              |
      | closeFeeFlatMax          | 1000           |
    And create the saving product
    Then cloud should response with code 200
    And request should be created
    When I log in with username checker and password @penCBS2019
    And disapprove it
    Then cloud should response with code 200
    And saving product shouldn't appear in the system

  Scenario: Modify and approve saving product
    Given there is the saving product with name Serenity Saving Product or code SSP
    When I log in with username maker and password @penCBS2019
    And I fill up saving fields such as accounts
      | saving | interest | interestExpense | depositFee | depositFeeIncome | withdrawalFee | withdrawalFeeIncome | managementFee | managementFeeIncome | entryFee | entryFeeIncome | closeFee | closeFeeIncome |
      | 163    | 164      | 165             | 173        | 174              | 173           | 174                 | 175           | 176                 | 178      | 177            | 180      | 179            |
    And saving general parameters
      | name                     | Serenity Saving Product |
      | interestAccrualFrequency | DAILY                   |
      | postingFrequency         | END_OF_MONTH            |
      | capitalized              | false                   |
      | code                     | SSP                     |
      | statusType               | ACTIVE                  |
      | initialAmountMin         | 0                       |
      | initialAmountMax         | 1000000                 |
      | interestRateMin          | 1                       |
      | interestRateMax          | 30                      |
      | currencyId               | 1                       |
      | minBalance               | 1000                    |
      | depositAmountMin         | 1000                    |
      | depositAmountMax         | 100000                  |
      | depositFeeRateMin        | 0                       |
      | depositFeeRateMax        | 10                      |
      | depositFeeFlatMin        | 0                       |
      | depositFeeFlatMax        | 1000                    |
      | withdrawalAmountMin      | 5000                    |
      | withdrawalAmountMax      | 50000                   |
      | withdrawalFeeRateMin     | 0                       |
      | withdrawalFeeRateMax     | 10                      |
      | withdrawalFeeFlatMin     | 0                       |
      | withdrawalFeeFlatMax     | 1000                    |
      | managementFeeRateMin     | 0                       |
      | managementFeeRateMax     | 10                      |
      | managementFeeFlatMin     | 0                       |
      | managementFeeFlatMax     | 1000                    |
      | managementFeeFrequency   | END_OF_MONTH            |
      | entryFeeRateMin          | 0                       |
      | entryFeeRateMax          | 10                      |
      | entryFeeFlatMin          | 0                       |
      | entryFeeFlatMax          | 1000                    |
      | closeFeeRateMin          | 0                       |
      | closeFeeRateMax          | 10                      |
      | closeFeeFlatMin          | 0                       |
      | closeFeeFlatMax          | 1000                    |
    And modify the saving product
    Then cloud should response with code 200
    And request should be created

    And modify the saving product
    Then cloud should response with code 500
    And error code should be internal_error
    And message should be This object has already active request!

    When I log in with username checker and password @penCBS2019
    And approve it
    Then cloud should response with code 200
    And saving product should appear in the system

  Scenario: Create a pending request of a saving product
    When I log in with username maker and password @penCBS2019
    And I fill up saving fields such as accounts
      | saving | interest | interestExpense | depositFee | depositFeeIncome | withdrawalFee | withdrawalFeeIncome | managementFee | managementFeeIncome | entryFee | entryFeeIncome | closeFee | closeFeeIncome |
      | 163    | 164      | 165             | 173        | 174              | 173           | 174                 | 175           | 176                 | 178      | 177            | 180      | 179            |
    And saving general parameters
      | name                     | random       |
      | interestAccrualFrequency | DAILY        |
      | postingFrequency         | END_OF_MONTH |
      | capitalized              | true         |
      | code                     | random       |
      | statusType               | ACTIVE       |
      | initialAmountMin         | 0            |
      | initialAmountMax         | 1000000      |
      | interestRateMin          | 2            |
      | interestRateMax          | 10           |
      | currencyId               | 1            |
      | minBalance               | 1000         |
      | depositAmountMin         | 1000         |
      | depositAmountMax         | 100000       |
      | depositFeeRateMin        | 0            |
      | depositFeeRateMax        | 10           |
      | depositFeeFlatMin        | 0            |
      | depositFeeFlatMax        | 1000         |
      | withdrawalAmountMin      | 5000         |
      | withdrawalAmountMax      | 50000        |
      | withdrawalFeeRateMin     | 0            |
      | withdrawalFeeRateMax     | 10           |
      | withdrawalFeeFlatMin     | 0            |
      | withdrawalFeeFlatMax     | 1000         |
      | managementFeeRateMin     | 0            |
      | managementFeeRateMax     | 10           |
      | managementFeeFlatMin     | 0            |
      | managementFeeFlatMax     | 1000         |
      | managementFeeFrequency   | END_OF_MONTH |
      | entryFeeRateMin          | 0            |
      | entryFeeRateMax          | 10           |
      | entryFeeFlatMin          | 0            |
      | entryFeeFlatMax          | 1000         |
      | closeFeeRateMin          | 0            |
      | closeFeeRateMax          | 10           |
      | closeFeeFlatMin          | 0            |
      | closeFeeFlatMax          | 1000         |
    And create the saving product
    Then cloud should response with code 200
    And request should be created
    And appear in Maker/Checker tab
    And saving product shouldn't appear in the system