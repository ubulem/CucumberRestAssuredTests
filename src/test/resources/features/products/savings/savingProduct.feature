@WIP
@Products
Feature: Operations with saving products
  In order to work with savings
  I create saving product as admin, as only maker and as only checker

  Background: Log in as admin
    When I log in with username admin and password admin
    Then cloud should response with code 200

  Scenario: Create saving product with the same name
    Given there is the saving product with name Serenity Saving Product or code SSP
    And I fill up saving fields such as accounts
      | saving | interest | interestExpense | depositFee | depositFeeIncome | withdrawalFee | withdrawalFeeIncome | managementFee | managementFeeIncome | entryFee | entryFeeIncome | closeFee | closeFeeIncome |
      | 163    | 164      | 165             | 173        | 174              | 173           | 174                 | 175           | 176                 | 178      | 177            | 180      | 179            |
    And saving general parameters
      | name                     | Serenity Saving Product |
      | interestAccrualFrequency | DAILY                   |
      | postingFrequency         | END_OF_MONTH            |
      | capitalized              | true                    |
      | code                     | SSP                     |
      | statusType               | ACTIVE                  |
      | initialAmountMin         | 0                       |
      | initialAmountMax         | 1000000                 |
      | interestRateMin          | 2                       |
      | interestRateMax          | 10                      |
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
    And create the saving product
    Then cloud should response with code 400
    And error code should be invalid
    And message should be Name is taken.

  Scenario: Create random active saving product
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
    And not appear in Maker/Checker tab
    And saving product should appear in the system

  Scenario: Create random inactive saving product
    And I fill up saving fields such as accounts
      | saving | interest | interestExpense | depositFee | depositFeeIncome | withdrawalFee | withdrawalFeeIncome | managementFee | managementFeeIncome | entryFee | entryFeeIncome | closeFee | closeFeeIncome |
      | 163    | 164      | 165             | 173        | 174              | 173           | 174                 | 175           | 176                 | 178      | 177            | 180      | 179            |
    And saving general parameters
      | name                     | random       |
      | interestAccrualFrequency | DAILY        |
      | postingFrequency         | END_OF_MONTH |
      | capitalized              | true         |
      | code                     | random       |
      | statusType               | INACTIVE     |
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
    And not appear in Maker/Checker tab
    And saving product shouldn't appear in the system
    When I click Show all button on SAVINGS page
    Then saving product should appear in the list

  Scenario: Modify saving product
    Given there is the saving product with name Serenity Saving Product or code SSP
    When I fill up saving fields such as accounts
      | saving | interest | interestExpense | depositFee | depositFeeIncome | withdrawalFee | withdrawalFeeIncome | managementFee | managementFeeIncome | entryFee | entryFeeIncome | closeFee | closeFeeIncome |
      | 163    | 164      | 165             | 173        | 174              | 173           | 174                 | 175           | 176                 | 178      | 177            | 180      | 179            |
    And saving general parameters
      | name                     | Serenity Saving Product |
      | interestAccrualFrequency | DAILY                   |
      | postingFrequency         | END_OF_MONTH            |
      | capitalized              | true                    |
      | code                     | SSP                     |
      | statusType               | ACTIVE                  |
      | initialAmountMin         | 0                       |
      | initialAmountMax         | 1000000                 |
      | interestRateMin          | 1                       |
      | interestRateMax          | 20                      |
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
    And not appear in Maker/Checker tab