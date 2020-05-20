@Reschedule
Feature: Reschedule One installment loan (annual) after maturity date

  Background: Log in as admin
    When I log in with username admin and password admin
    Then cloud should response with code 200

  Scenario: Reschedule One installment loan (annual) after maturity date
    Given there is a loan product with name Test Product By Maturity or code TPBM
    When I get current accounts for person with id 3
    And I create transaction with parameters
      | amount          | 1000000                        |
      | createdAt       | 2018-01-12T15:00:00            |
      | debitAccountId  | 140                            |
      | creditAccountId | -1                             |
      | description     | Initial payment for Steve Jobs |
      | autoPrint       | false                          |
    Then cloud should response with code 200

    And I create loan application for person with parameters
      | loanProductName        | Test Product By Maturity |
      | profileId              | 3                        |
      | currencyId             | 1                        |
      | scheduleType           | ANNUITY_ANNUAL           |
      | scheduleBasedType      | BY_MATURITY              |
      | amount                 | 1000000                  |
      | interestRate           | 18                       |
      | gracePeriod            | 0                        |
      | maturity               |                          |
      | maturityDate           | 2019-11-22               |
      | disbursementDate       | 2018-11-22               |
      | preferredRepaymentDate | 2019-11-22               |
      | userId                 | 3                        |
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

    When I actualize created loan on 2020-01-31
    Then cloud should response with code 200
    And message should be Actualize loan started

    When I make NORMAL_REPAYMENT for 200000 on 2020-01-31
    Then cloud should response with code 200
    And request should be created
    And not appear in Maker/Checker tab

    When I actualize created loan on 2020-02-06
    Then cloud should response with code 200
    And message should be Actualize loan started

    When I make reschedule with parameters
      | rescheduleDate | firstInstallmentDate | gracePeriod | interestRate | maturity | maturityDate |
      | 2020-02-06     | 2020-03-09           | 0           | 9            |          | 2020-12-09   |
    Then cloud should response with code 200
    And schedule should like this
"""
{
  "columns" : [ "#", "Payment Date", "Principal", "Interest", "Accrued Interest", "Paid Principal", "Paid Interest", "Total", "Planned OLB" ],
  "types" : [ "INTEGER", "DATE", "DECIMAL", "DECIMAL", "DECIMAL", "DECIMAL", "DECIMAL", "DECIMAL", "DECIMAL" ],
  "rows" : [ {
    "overdue" : "NOT_OVERDUE",
    "data" : [ 1, "2019-11-22", 0.00, 200000.00, 0, 0.00, 200000.00, 0.00, 1000000.00 ],
    "status" : "PAID"
  }, {
    "overdue" : "NOT_OVERDUE",
    "data" : [ 2, "2020-02-06", 0.00, 0.00, 0, 0.00, 0.00, 0.00, 1000000.00 ],
    "status" : "PAID"
  }, {
    "overdue" : "OVERDUE",
    "data" : [ 3, "2020-03-09", 0.00, 17000.00, 217000.00, 0.00, 0.00, 17000.00, 1000000.00 ],
    "status" : "UNPAID"
  }, {
    "overdue" : "OVERDUE",
    "data" : [ 4, "2020-03-09", 512333.74, 8250.00, 0, 0.00, 0.00, 520583.74, 1000000.00 ],
    "status" : "UNPAID"
  }, {
    "overdue" : "NOT_OVERDUE",
    "data" : [ 5, "2020-12-09", 487666.26, 32917.47, 0, 0.00, 0.00, 520583.73, 487666.26 ],
    "status" : "UNPAID"
  } ],
  "totals" : [ null, null, 1000000.00, 258167.47, 217000.00, 0.00, 200000.00, 1058167.47, null ]
}
"""