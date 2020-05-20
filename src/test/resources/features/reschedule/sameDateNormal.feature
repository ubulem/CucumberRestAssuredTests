@Reschedule
Feature: Reschedule same date as the installment date (normal repayments) with late

  Background: Log in as admin
    When I log in with username admin and password admin
    Then cloud should response with code 200

  Scenario: Reschedule same date as the installment date (normal repayments) with late
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
      | scheduleType           | ANNUITY_MONTHLY          |
      | scheduleBasedType      | BY_MATURITY              |
      | amount                 | 1000000                  |
      | interestRate           | 18                       |
      | gracePeriod            | 0                        |
      | maturity               |                          |
      | maturityDate           | 2019-08-12               |
      | disbursementDate       | 2018-10-12               |
      | preferredRepaymentDate | 2018-11-12               |
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

    When I actualize created loan on 2018-11-12
    Then cloud should response with code 200
    And message should be Actualize loan started

    When I make NORMAL_REPAYMENT for 108434.18 on 2018-11-12
    Then cloud should response with code 200
    And request should be created
    And not appear in Maker/Checker tab

    When I actualize created loan on 2018-12-12
    Then cloud should response with code 200
    And message should be Actualize loan started

    When I make NORMAL_REPAYMENT for 108434.18 on 2018-12-12
    Then cloud should response with code 200
    And request should be created
    And not appear in Maker/Checker tab

    When I actualize created loan on 2019-03-12
    Then cloud should response with code 200
    And message should be Actualize loan started

    When I make reschedule with parameters
      | rescheduleDate | firstInstallmentDate | gracePeriod | interestRate | maturity | maturityDate |
      | 2019-03-12     | 2019-04-12           | 0           | 12           |          | 2019-12-12   |
    Then cloud should response with code 200
    And schedule should like this
"""
{
  "columns" : [ "#", "Payment Date", "Principal", "Interest", "Accrued Interest", "Paid Principal", "Paid Interest", "Total", "Planned OLB" ],
  "types" : [ "INTEGER", "DATE", "DECIMAL", "DECIMAL", "DECIMAL", "DECIMAL", "DECIMAL", "DECIMAL", "DECIMAL" ],
  "rows" : [ {
    "overdue" : "NOT_OVERDUE",
    "data" : [ 1, "2018-11-12", 93434.18, 15000.00, 15000.00, 93434.18, 15000.00, 0.00, 1000000.00 ],
    "status" : "PAID"
  }, {
    "overdue" : "NOT_OVERDUE",
    "data" : [ 2, "2018-12-12", 94835.69, 13598.49, 13598.49, 94835.69, 13598.49, 0.00, 906565.82 ],
    "status" : "PAID"
  }, {
    "overdue" : "NOT_OVERDUE",
    "data" : [ 3, "2019-01-14", 0.00, 0.00, 0, 0.00, 0.00, 0.00, 811730.13 ],
    "status" : "PAID"
  }, {
    "overdue" : "NOT_OVERDUE",
    "data" : [ 4, "2019-02-12", 0.00, 0.00, 0, 0.00, 0.00, 0.00, 811730.13 ],
    "status" : "PAID"
  }, {
    "overdue" : "NOT_OVERDUE",
    "data" : [ 5, "2019-03-12", 0.00, 0.00, 0, 0.00, 0.00, 0.00, 811730.13 ],
    "status" : "PAID"
  }, {
    "overdue" : "OVERDUE",
    "data" : [ 6, "2019-04-12", 0.00, 32174.58, 32174.58, 0.00, 0.00, 32174.58, 811730.13 ],
    "status" : "UNPAID"
  }, {
    "overdue" : "OVERDUE",
    "data" : [ 7, "2019-04-12", 86644.37, 8117.30, 0, 0.00, 0.00, 94761.67, 811730.13 ],
    "status" : "UNPAID"
  }, {
    "overdue" : "OVERDUE",
    "data" : [ 8, "2019-05-13", 87510.81, 7250.86, 0, 0.00, 0.00, 94761.67, 725085.76 ],
    "status" : "UNPAID"
  }, {
    "overdue" : "OVERDUE",
    "data" : [ 9, "2019-06-12", 88385.92, 6375.75, 0, 0.00, 0.00, 94761.67, 637574.95 ],
    "status" : "UNPAID"
  }, {
    "overdue" : "OVERDUE",
    "data" : [ 10, "2019-07-12", 89269.78, 5491.89, 0, 0.00, 0.00, 94761.67, 549189.03 ],
    "status" : "UNPAID"
  }, {
    "overdue" : "OVERDUE",
    "data" : [ 11, "2019-08-12", 90162.48, 4599.19, 0, 0.00, 0.00, 94761.67, 459919.25 ],
    "status" : "UNPAID"
  }, {
    "overdue" : "OVERDUE",
    "data" : [ 12, "2019-09-12", 91064.10, 3697.57, 0, 0.00, 0.00, 94761.67, 369756.77 ],
    "status" : "UNPAID"
  }, {
    "overdue" : "OVERDUE",
    "data" : [ 13, "2019-10-14", 91974.74, 2786.93, 0, 0.00, 0.00, 94761.67, 278692.67 ],
    "status" : "UNPAID"
  }, {
    "overdue" : "OVERDUE",
    "data" : [ 14, "2019-11-12", 92894.49, 1867.18, 0, 0.00, 0.00, 94761.67, 186717.93 ],
    "status" : "UNPAID"
  }, {
    "overdue" : "OVERDUE",
    "data" : [ 15, "2019-12-12", 93823.44, 938.23, 0, 0.00, 0.00, 94761.67, 93823.44 ],
    "status" : "UNPAID"
  } ],
  "totals" : [ null, null, 1000000.00, 101897.97, 60773.07, 188269.87, 28598.49, 885029.61, null ]
}
"""
    When I actualize created loan on 2019-06-12
    Then cloud should response with code 200
    And message should be Actualize loan started

    When I make NORMAL_REPAYMENT for 318926.39 on 2019-06-12
    Then cloud should response with code 200
    And request should be created
    And not appear in Maker/Checker tab
    And schedule should like this
"""
{
  "columns" : [ "#", "Payment Date", "Principal", "Interest", "Accrued Interest", "Paid Principal", "Paid Interest", "Total", "Planned OLB" ],
  "types" : [ "INTEGER", "DATE", "DECIMAL", "DECIMAL", "DECIMAL", "DECIMAL", "DECIMAL", "DECIMAL", "DECIMAL" ],
  "rows" : [ {
    "overdue" : "NOT_OVERDUE",
    "data" : [ 1, "2018-11-12", 93434.18, 15000.00, 15000.00, 93434.18, 15000.00, 0.00, 1000000.00 ],
    "status" : "PAID"
  }, {
    "overdue" : "NOT_OVERDUE",
    "data" : [ 2, "2018-12-12", 94835.69, 13598.49, 13598.49, 94835.69, 13598.49, 0.00, 906565.82 ],
    "status" : "PAID"
  }, {
    "overdue" : "NOT_OVERDUE",
    "data" : [ 3, "2019-01-14", 0.00, 0.00, 0, 0.00, 0.00, 0.00, 811730.13 ],
    "status" : "PAID"
  }, {
    "overdue" : "NOT_OVERDUE",
    "data" : [ 4, "2019-02-12", 0.00, 0.00, 0, 0.00, 0.00, 0.00, 811730.13 ],
    "status" : "PAID"
  }, {
    "overdue" : "NOT_OVERDUE",
    "data" : [ 5, "2019-03-12", 0.00, 0.00, 0, 0.00, 0.00, 0.00, 811730.13 ],
    "status" : "PAID"
  }, {
    "overdue" : "NOT_OVERDUE",
    "data" : [ 6, "2019-04-12", 0.00, 32174.58, 32174.58, 0.00, 32174.58, 0.00, 811730.13 ],
    "status" : "PAID"
  }, {
    "overdue" : "NOT_OVERDUE",
    "data" : [ 7, "2019-04-12", 86644.37, 8117.30, 8117.30, 86644.37, 8117.30, 0.00, 811730.13 ],
    "status" : "PAID"
  }, {
    "overdue" : "NOT_OVERDUE",
    "data" : [ 8, "2019-05-13", 87510.81, 7250.86, 7250.86, 87510.81, 7250.86, 0.00, 725085.76 ],
    "status" : "PAID"
  }, {
    "overdue" : "NOT_OVERDUE",
    "data" : [ 9, "2019-06-12", 88385.92, 6375.75, 6375.75, 88385.92, 6375.75, 0.00, 637574.95 ],
    "status" : "PAID"
  }, {
    "overdue" : "OVERDUE",
    "data" : [ 10, "2019-07-12", 89269.78, 5491.89, 0.00, 0.00, 0.00, 94761.67, 549189.03 ],
    "status" : "UNPAID"
  }, {
    "overdue" : "OVERDUE",
    "data" : [ 11, "2019-08-12", 90162.48, 4599.19, 0, 0.00, 0.00, 94761.67, 459919.25 ],
    "status" : "UNPAID"
  }, {
    "overdue" : "OVERDUE",
    "data" : [ 12, "2019-09-12", 91064.10, 3697.57, 0, 0.00, 0.00, 94761.67, 369756.77 ],
    "status" : "UNPAID"
  }, {
    "overdue" : "OVERDUE",
    "data" : [ 13, "2019-10-14", 91974.74, 2786.93, 0, 0.00, 0.00, 94761.67, 278692.67 ],
    "status" : "UNPAID"
  }, {
    "overdue" : "OVERDUE",
    "data" : [ 14, "2019-11-12", 92894.49, 1867.18, 0, 0.00, 0.00, 94761.67, 186717.93 ],
    "status" : "UNPAID"
  }, {
    "overdue" : "OVERDUE",
    "data" : [ 15, "2019-12-12", 93823.44, 938.23, 0, 0.00, 0.00, 94761.67, 93823.44 ],
    "status" : "UNPAID"
  } ],
  "totals" : [ null, null, 1000000.00, 101897.97, 82516.98, 450810.97, 82516.98, 568570.02, null ]
}
"""