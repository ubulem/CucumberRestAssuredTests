@Contracts
@WIP
Feature: Operations with loan applications and loans
  In order to create loan
  I create loan application
  and go through submission process

  Background: Log in as admin
    When I log in with username admin and password admin
    Then cloud should response with code 200

  Scenario: Operations with loans based on installment date
  Create, submit, approve, disburse, actualize, repay and roll-back operations on loan.
    Given there is a loan product with name Test Product By Installment or code TPBI
    When I create loan application for person with parameters
      | loanProductName            | Test Product By Installment |
      | profileId              | -1                      |
      | currencyId             | 1                           |
      | scheduleType           | ANNUITY_MONTHLY             |
      | scheduleBasedType      | BY_INSTALLMENT              |
      | amount                 | 100000                      |
      | interestRate           | 12                          |
      | gracePeriod            | 0                           |
      | maturity               | 12                          |
      | maturityDate           |                             |
      | disbursementDate       | 2019-03-12                  |
      | preferredRepaymentDate | 2019-04-12                  |
      | userId                 | 3                           |
    Then cloud should response with code 200

    When I submit this loan application
    Then cloud should response with code 200

    When I approve this loan application
    Then cloud should response with code 200
    And status should be APPROVED

    When I disburse this loan application
    Then cloud should response with code 200
    And request should be created
    And not appear in Maker/Checker tab
    And status should be DISBURSED

    When I actualize created loan on 2019-07-23
    Then cloud should response with code 200
    And message should be Actualize loan started

    When I make NORMAL_REPAYMENT for 30000 on 2019-07-23
    Then cloud should response with code 200
    And request should be created
    And not appear in Maker/Checker tab
    And REPAYMENT_OF_PRINCIPAL event should appear in Events tab

    When I rollback on 2019-07-23
    Then cloud should response with code 200
    And request should be created
    And not appear in Maker/Checker tab
    And REPAYMENT_OF_PRINCIPAL event should disappear in Events tab

  Scenario: Operations with loans (full rollback) based on installment date
  Loan must become deleted (e.g. pending) and respective application must become pending
    Given there is a loan product with name Test Product By Installment or code TPBI
    When I create loan application for person with parameters
      | loanProductName            | Test Product By Installment |
      | profileId              | -1                      |
      | currencyId             | 1                           |
      | scheduleType           | ANNUITY_MONTHLY             |
      | scheduleBasedType      | BY_INSTALLMENT              |
      | amount                 | 100000                      |
      | interestRate           | 12                          |
      | gracePeriod            | 0                           |
      | maturity               | 12                          |
      | maturityDate           |                             |
      | disbursementDate       | 2019-03-12                  |
      | preferredRepaymentDate | 2019-04-12                  |
      | userId                 | 3                           |
    Then cloud should response with code 200

    When I submit this loan application
    Then cloud should response with code 200

    When I approve this loan application
    Then cloud should response with code 200
    And status should be APPROVED

    When I disburse this loan application
    Then cloud should response with code 200
    And request should be created
    And not appear in Maker/Checker tab
    And status should be DISBURSED

    When I rollback on 2019-03-12
    Then cloud should response with code 200
    And request should be created
    And not appear in Maker/Checker tab
    And status should be PENDING