@WIP
@Products
Feature: Operations with loan products
  In order to work with loans
  I create loan product

  Background: Log in as admin
    When I log in with username admin and password admin
    Then cloud should response with code 200

  Scenario: Create loan product with the same name or code
    Given there is the loan product with name Test Product By Installment or code TPBI
    And I create loan product with accounts
      | principal | interestAccrual | interestIncome | writeOffPortfolio | writeOffInterest | earlyPartialRepaymentFeeIncome | earlyTotalRepaymentFeeIncome |
      | 11        | 12              | 75             | 158               | 159              | 152                            | 152                          |
    And other parameters
      | name                        | scheduleType    | scheduleBasedType | code | statusType | interestRateMin | interestRateMax | amountMin | amountMax | earlyPartialRepaymentFeeType | earlyPartialRepaymentFeeValue | earlyTotalRepaymentFeeType | earlyTotalRepaymentFeeValue | maturityMin | maturityMax | maturityDateMax | gracePeriodMin | gracePeriodMax | hasPayees | currencyId | topUpAllow | topUpMaxLimit | topUpMaxOlb |
      | Test Product By Installment | ANNUITY_MONTHLY | BY_INSTALLMENT    | TPBI | ACTIVE     | 5               | 30              | 1000      | 1000000   | OLB                          | 0                             | OLB                        | 2                           | 3           | 36          | 2033-12-31      | 0              | 3              | false     | 1          | false      | 0             | 0           |
    And create the loan product
    Then cloud should response with code 400
    And error code should be invalid
    And message should be Name is taken.

  Scenario: Create random active loan product
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
      | name   | scheduleType    | code   | statusType | scheduleBasedType | interestRateMin | interestRateMax | amountMin | amountMax | earlyPartialRepaymentFeeType | earlyPartialRepaymentFeeValue | earlyTotalRepaymentFeeType | earlyTotalRepaymentFeeValue | maturityMin | maturityMax | maturityDateMax | gracePeriodMin | gracePeriodMax | hasPayees | currencyId | topUpAllow | topUpMaxLimit | topUpMaxOlb |
      | random | ANNUITY_MONTHLY | random | ACTIVE     | BY_INSTALLMENT    | 5               | 30              | 1000      | 1000000   | OLB                          | 0                             | OLB                        | 2                           | 3           | 36          | 2033-12-31      | 0              | 3              | false     | 1          | false      | 0             | 0           |
    And create the loan product
    Then cloud should response with code 200
    And request should be created
    And not appear in Maker/Checker tab
    And loan product should appear in the system

  Scenario: Modify a loan product
    Given there is the loan product with name Test Product By Installment or code TPBI
    When I create loan product with accounts
      | principal | interestAccrual | interestIncome | writeOffPortfolio | writeOffInterest | earlyPartialRepaymentFeeIncome | earlyTotalRepaymentFeeIncome |
      | 11        | 12              | 75             | 158               | 159              | 152                            | 152                          |
    And other parameters
      | name                        | scheduleType | code | statusType | scheduleBasedType | interestRateMin | interestRateMax | amountMin | amountMax | earlyPartialRepaymentFeeType | earlyPartialRepaymentFeeValue | earlyTotalRepaymentFeeType | earlyTotalRepaymentFeeValue | maturityMin | maturityMax | maturityDateMax | gracePeriodMin | gracePeriodMax | hasPayees | currencyId | topUpAllow | topUpMaxLimit | topUpMaxOlb |
      | Test Product By Installment | FLAT_MONTHLY | TPBI | ACTIVE     | BY_INSTALLMENT    | 10              | 50              | 10        | 10000000  | OLB                          | 0                             | OLB                        | 2                           | 3           | 36          | 2033-12-31      | 0              | 3              | false     | 1          | false      | 0             | 0           |
    And modify loan product
    Then cloud should response with code 200
    And request should be created
    And not appear in Maker/Checker tab

  Scenario: Create random inactive loan product
    When I create loan product with accounts
      | principal | interestAccrual | interestIncome | writeOffPortfolio | writeOffInterest | earlyPartialRepaymentFeeIncome | earlyTotalRepaymentFeeIncome |
      | 11        | 12              | 75             | 158               | 159              | 152                            | 152                          |
    And other parameters
      | name   | scheduleType    | code   | statusType | scheduleBasedType | interestRateMin | interestRateMax | amountMin | amountMax | earlyPartialRepaymentFeeType | earlyPartialRepaymentFeeValue | earlyTotalRepaymentFeeType | earlyTotalRepaymentFeeValue | maturityMin | maturityMax | maturityDateMax | gracePeriodMin | gracePeriodMax | hasPayees | currencyId | topUpAllow | topUpMaxLimit | topUpMaxOlb |
      | random | ANNUITY_MONTHLY | random | INACTIVE   | BY_MATURITY       | 5               | 30              | 1000      | 1000000   | OLB                          | 0                             | OLB                        | 2                           | 3           | 36          | 2033-12-31      | 0              | 3              | false     | 1          | false      | 0             | 0           |
    And create the loan product
    Then cloud should response with code 200
    And request should be created
    And not appear in Maker/Checker tab
    And loan product shouldn't appear in the system
    When I click Show all button on LOANS page
    Then loan product should appear in the list