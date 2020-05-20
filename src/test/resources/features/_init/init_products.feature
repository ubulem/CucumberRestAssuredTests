@Init
Feature: Initial products setup for further scenarios

  Background: Log in as admin to setup initial data
    When I log in with username Administrator and password admin
    Then cloud should response with code 200

  Scenario: Create loan product with installment basis
    Given there is no loan product with name Test Product By Installment or code TPBI
    When I create loan product with accounts
      | principal | interestAccrual | interestIncome | writeOffPortfolio | writeOffInterest | earlyPartialRepaymentFeeIncome | earlyTotalRepaymentFeeIncome |
      | 11        | 12              | 75             | 158               | 159              | 152                            | 152                          |
    And provisions
      | lateDays | ratePrincipal | rateInterest | ratePenalty |
      | 15       | 5             | 5            | 5           |
      | 30       | 10            | 10           | 10          |
      | 60       | 30            | 30           | 30          |
      | 90       | 50            | 50           | 50          |
      | 180      | 80            | 80           | 80          |
    And other parameters
      | name                        | scheduleType    | scheduleBasedType | code | statusType | interestRateMin | interestRateMax | amountMin | amountMax | earlyTotalRepaymentFeeType | earlyTotalRepaymentFeeValue | earlyPartialRepaymentFeeType | earlyPartialRepaymentFeeValue | maturityMin | maturityMax | maturityDateMax | gracePeriodMin | gracePeriodMax | hasPayees | currencyId | topUpAllow | topUpMaxLimit | topUpMaxOlb |
      | Test Product By Installment | ANNUITY_MONTHLY | BY_INSTALLMENT    | TPBI | ACTIVE     | 5               | 30              | 1000      | 1000000   | OLB                        | 2                           | OLB                          | 0                             | 3           | 36          | 2033-12-31      | 0              | 3              | false     | 1          | false      | 0             | 0           |
    And create the loan product
    Then cloud should response with code 200
    And loan product should appear in the system

  Scenario: Create loan product with maturity date basis
    Given there is no loan product with name Test Product By Maturity or code TPBM
    When I create loan product with accounts
      | principal | interestAccrual | interestIncome | writeOffPortfolio | writeOffInterest | earlyPartialRepaymentFeeIncome | earlyTotalRepaymentFeeIncome |
      | 11        | 12              | 75             | 158               | 159              | 152                            | 152                          |
    And provisions
      | lateDays | ratePrincipal | rateInterest | ratePenalty |
      | 15       | 5             | 5            | 5           |
      | 30       | 10            | 10           | 10          |
      | 60       | 30            | 30           | 30          |
      | 90       | 50            | 50           | 50          |
      | 180      | 80            | 80           | 80          |
    And other parameters
      | name                     | scheduleType | scheduleBasedType | code | statusType | interestRateMin | interestRateMax | amountMin | amountMax | earlyPartialRepaymentFeeType | earlyPartialRepaymentFeeValue | earlyTotalRepaymentFeeType | earlyTotalRepaymentFeeValue | maturityMin | maturityMax | maturityDateMax | gracePeriodMin | gracePeriodMax | hasPayees | currencyId | topUpAllow | topUpMaxLimit | topUpMaxOlb |
      | Test Product By Maturity |              | BY_MATURITY       | TPBM | ACTIVE     | 5               | 30              | 1000      | 1000000   | RECEIVED_AMOUNT              | 1                             | AMOUNT_DUE                 | 2                           | 3           | 36          | 2033-12-31      | 0              | 1000           | false     | 1          | false      | 0             | 0           |
    And create the loan product
    Then cloud should response with code 200
    And loan product should appear in the system

  @WIP
  Scenario: Create saving product with certain data
    Given there is no saving product with name Serenity Saving Product or code SSP
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
    Then cloud should response with code 200
    And saving product should appear in the system

  @WIP
  Scenario: Create term deposit product with certain name
    Given there is no term deposit product with name Serenity Term Deposit Product or code STDP
    When I fill up term deposit fields such as accounts
      | principal | interestAccrual | interestExpense | interestWriteOff | earlyCloseFee |
      | 168       | 169             | 96              | 159              | 182           |
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
    Then cloud should response with code 200
    And term deposit product should appear in the system