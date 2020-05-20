@WIP
@MakerChecker
@Products
Feature: Check Maker-checker system permissions for loan products
  Maker can create or delete his own requests as well as
  checker can approve or reject only his ones
  Entities under the system:
  1. loan products (create, edit)
  1.1 loan applications (disbursement)
  1.2 loans (repayment, rollback)

  Scenario: Create and approve random loan product
    When I log in with username maker and password @penCBS2019
    And I create loan product with accounts
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
    When I log in with username checker and password @penCBS2019
    And approve it
    Then cloud should response with code 200
    And loan product should appear in the system

  Scenario: Create and approve random loan product without respective maker permission
    When I log in with username makerfu and password @penCBS2019
    And I create loan product with accounts
      | principal | interestAccrual | interestIncome | writeOffPortfolio | writeOffInterest | earlyPartialRepaymentFeeIncome | earlyTotalRepaymentFeeIncome |
      | 11        | 12              | 75             | 158               | 159              | 152                            | 152                          |
    And other parameters
      | name   | scheduleType  | code   | statusType | scheduleBasedType | interestRateMin | interestRateMax | amountMin | amountMax | earlyPartialRepaymentFeeType | earlyPartialRepaymentFeeValue | earlyTotalRepaymentFeeType | earlyTotalRepaymentFeeValue | maturityMin | maturityMax | maturityDateMax | gracePeriodMin | gracePeriodMax | hasPayees | currencyId | topUpAllow | topUpMaxLimit | topUpMaxOlb |
      | random | FLAT_BIWEEKLY | random | ACTIVE     | BY_MATURITY       | 5               | 30              | 1000      | 1000000   | OLB                          | 0                             | OLB                        | 2                           | 3           | 36          | 2033-12-31      | 0              | 3              | false     | 1          | false      | 0             | 0           |
    And create the loan product
    Then cloud should response with code 500
    And error code should be internal_error
    And message should be You don't have permissions - MAKER_FOR_LOAN_PRODUCT

  Scenario: Create and approve random loan product without respective checker permission
    When I log in with username maker and password @penCBS2019
    And I create loan product with accounts
      | principal | interestAccrual | interestIncome | writeOffPortfolio | writeOffInterest | earlyPartialRepaymentFeeIncome | earlyTotalRepaymentFeeIncome |
      | 11        | 12              | 75             | 158               | 159              | 152                            | 152                          |
    And other parameters
      | name   | scheduleType  | code   | statusType | scheduleBasedType | interestRateMin | interestRateMax | amountMin | amountMax | earlyTotalRepaymentFeeType | earlyTotalRepaymentFeeValue | earlyPartialRepaymentFeeType | earlyPartialRepaymentFeeValue | maturityMin | maturityMax | maturityDateMax | gracePeriodMin | gracePeriodMax | hasPayees | currencyId | topUpAllow | topUpMaxLimit | topUpMaxOlb |
      | random | FLAT_BIWEEKLY | random | ACTIVE     | BY_INSTALLMENT    | 5               | 30              | 1000      | 1000000   | OLB                        | 2                           | OLB                          | 0                             | 3           | 36          | 2033-12-31      | 0              | 3              | false     | 1          | false      | 0             | 0           |
    And create the loan product
    Then cloud should response with code 200
    And request should be created
    When I log in with username checkerfu and password @penCBS2019
    And approve it
    Then cloud should response with code 500
    And error code should be internal_error
    And message should be You don't have a permission to approve the request

  Scenario: Create and disapprove loan product
    Given there is no loan product with name LoanToDelete or code LTD
    When I log in with username maker and password @penCBS2019
    And I create loan product with accounts
      | principal | interestAccrual | interestIncome | writeOffPortfolio | writeOffInterest | earlyPartialRepaymentFeeIncome | earlyTotalRepaymentFeeIncome |
      | 11        | 12              | 75             | 158               | 159              | 152                            | 152                          |
    And other parameters
      | name         | scheduleType    | code | statusType | scheduleBasedType | interestRateMin | interestRateMax | earlyPartialRepaymentFeeType | earlyPartialRepaymentFeeValue | earlyTotalRepaymentFeeType | earlyTotalRepaymentFeeValue | amountMin | amountMax | maturityMin | maturityMax | maturityDateMax | gracePeriodMin | gracePeriodMax | hasPayees | currencyId | topUpAllow | topUpMaxLimit | topUpMaxOlb |
      | LoanToDelete | ANNUITY_MONTHLY | LTD  | ACTIVE     | BY_INSTALLMENT    | 5               | 30              | OLB                          | 0                             | OLB                        | 2                           | 1000      | 1000000   | 3           | 36          | 2033-12-31      | 0              | 3              | false     | 1          | false      | 0             | 0           |
    And create the loan product
    Then cloud should response with code 200
    And request should be created
    When I log in with username checker and password @penCBS2019
    And disapprove it
    Then cloud should response with code 200
    And loan product shouldn't appear in the system

  Scenario: Modify and approve loan product
    Given there is the loan product with name Test Product By Installment or code TPBI
    When I log in with username maker and password @penCBS2019
    And I create loan product with accounts
      | principal | interestAccrual | interestIncome | writeOffPortfolio | writeOffInterest | earlyPartialRepaymentFeeIncome | earlyTotalRepaymentFeeIncome |
      | 11        | 12              | 75             | 158               | 159              | 152                            | 152                          |
    And other parameters
      | name                        | scheduleType | code | statusType | scheduleBasedType | interestRateMin | interestRateMax | amountMin | amountMax | earlyTotalRepaymentFeeType | earlyTotalRepaymentFeeValue | earlyPartialRepaymentFeeType | earlyPartialRepaymentFeeValue | maturityMin | maturityMax | maturityDateMax | gracePeriodMin | gracePeriodMax | hasPayees | currencyId | topUpAllow | topUpMaxLimit | topUpMaxOlb |
      | Test Product By Installment | FLAT_MONTHLY | TPBI | ACTIVE     | BY_INSTALLMENT    | 10              | 30              | 100       | 10000000  | OLB                        | 2                           | OLB                          | 0                             | 3           | 36          | 2033-12-31      | 0              | 3              | false     | 1          | false      | 0             | 0           |
    And modify loan product
    Then cloud should response with code 200
    And request should be created

    And modify loan product
    Then cloud should response with code 500
    And error code should be internal_error
    And message should be This object has already active request!

    When I log in with username checker and password @penCBS2019
    And approve it
    Then cloud should response with code 200

  Scenario: Create a pending request of a loan product
    When I log in with username maker and password @penCBS2019
    And I create loan product with accounts
      | principal | interestAccrual | interestIncome | writeOffPortfolio | writeOffInterest | earlyPartialRepaymentFeeIncome | earlyTotalRepaymentFeeIncome |
      | 11        | 12              | 75             | 158               | 159              | 152                            | 152                          |
    And other parameters
      | name   | scheduleType  | code   | statusType | scheduleBasedType | interestRateMin | interestRateMax | amountMin | amountMax | earlyPartialRepaymentFeeType | earlyPartialRepaymentFeeValue | earlyTotalRepaymentFeeType | earlyTotalRepaymentFeeValue | maturityMin | maturityMax | maturityDateMax | gracePeriodMin | gracePeriodMax | hasPayees | currencyId | topUpAllow | topUpMaxLimit | topUpMaxOlb |
      | random | FLAT_BIWEEKLY | random | ACTIVE     | BY_MATURITY       | 5               | 30              | 1000      | 1000000   | OLB                          | 0                             | OLB                        | 2                           | 3           | 36          | 2033-12-31      | 0              | 3              | false     | 1          | false      | 0             | 0           |
    And create the loan product
    Then cloud should response with code 200
    And request should be created
    And appear in Maker/Checker tab
    And loan product shouldn't appear in the system