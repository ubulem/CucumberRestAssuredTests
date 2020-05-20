@Reschedule
Feature: Reschedule in the middle of the installment date (normal repayments) with late

  Background: Log in as admin
    When I log in with username admin and password admin
    Then cloud should response with code 200

  Scenario: Reschedule in the middle of the installment date (normal repayments) with late
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

    When I actualize created loan on 2019-01-14
    Then cloud should response with code 200
    And message should be Actualize loan started

    When I make NORMAL_REPAYMENT for 108434.18 on 2019-01-14
    Then cloud should response with code 200
    And request should be created
    And not appear in Maker/Checker tab

    When I actualize created loan on 2019-04-08
    Then cloud should response with code 200
    And message should be Actualize loan started

    When I make reschedule with parameters
      | rescheduleDate | firstInstallmentDate | gracePeriod | interestRate | maturity | maturityDate |
      | 2019-04-08     | 2019-05-08           | 0           | 12           |          | 2019-10-08   |
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
    "data" : [ 3, "2019-01-14", 96258.23, 12175.95, 12175.95, 96258.23, 12175.95, 0.00, 811730.13 ],
    "status" : "PAID"
  }, {
    "overdue" : "NOT_OVERDUE",
    "data" : [ 4, "2019-02-12", 0.00, 0.00, 0, 0.00, 0.00, 0.00, 715471.90 ],
    "status" : "PAID"
  }, {
    "overdue" : "NOT_OVERDUE",
    "data" : [ 5, "2019-03-12", 0.00, 0.00, 0, 0.00, 0.00, 0.00, 715471.90 ],
    "status" : "PAID"
  }, {
    "overdue" : "NOT_OVERDUE",
    "data" : [ 6, "2019-04-08", 0.00, 0.00, 0, 0.00, 0.00, 0.00, 715471.90 ],
    "status" : "PAID"
  }, {
    "overdue" : "OVERDUE",
    "data" : [ 7, "2019-05-08", 0.00, 26740.46, 26740.46, 0.00, 0.00, 26740.46, 715471.90 ],
    "status" : "UNPAID"
  }, {
    "overdue" : "OVERDUE",
    "data" : [ 8, "2019-05-08", 116298.79, 7154.72, 0, 0.00, 0.00, 123453.51, 715471.90 ],
    "status" : "UNPAID"
  }, {
    "overdue" : "OVERDUE",
    "data" : [ 9, "2019-06-10", 117461.78, 5991.73, 0, 0.00, 0.00, 123453.51, 599173.11 ],
    "status" : "UNPAID"
  }, {
    "overdue" : "OVERDUE",
    "data" : [ 10, "2019-07-08", 118636.40, 4817.11, 0, 0.00, 0.00, 123453.51, 481711.33 ],
    "status" : "UNPAID"
  }, {
    "overdue" : "OVERDUE",
    "data" : [ 11, "2019-08-08", 119822.76, 3630.75, 0, 0.00, 0.00, 123453.51, 363074.93 ],
    "status" : "UNPAID"
  }, {
    "overdue" : "OVERDUE",
    "data" : [ 12, "2019-09-09", 121020.99, 2432.52, 0, 0.00, 0.00, 123453.51, 243252.17 ],
    "status" : "UNPAID"
  }, {
    "overdue" : "OVERDUE",
    "data" : [ 13, "2019-10-08", 122231.18, 1222.31, 0, 0.00, 0.00, 123453.49, 122231.18 ],
    "status" : "UNPAID"
  } ],
  "totals" : [ null, null, 1000000.00, 92764.04, 67514.90, 284528.10, 40774.44, 767461.50, null ]
}
"""
    When I actualize created loan on 2019-05-08
    Then cloud should response with code 200
    And message should be Actualize loan started

    When I make NORMAL_REPAYMENT for 152609.28 on 2019-05-08
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
    "data" : [ 3, "2019-01-14", 96258.23, 12175.95, 12175.95, 96258.23, 12175.95, 0.00, 811730.13 ],
    "status" : "PAID"
  }, {
    "overdue" : "NOT_OVERDUE",
    "data" : [ 4, "2019-02-12", 0.00, 0.00, 0, 0.00, 0.00, 0.00, 715471.90 ],
    "status" : "PAID"
  }, {
    "overdue" : "NOT_OVERDUE",
    "data" : [ 5, "2019-03-12", 0.00, 0.00, 0, 0.00, 0.00, 0.00, 715471.90 ],
    "status" : "PAID"
  }, {
    "overdue" : "NOT_OVERDUE",
    "data" : [ 6, "2019-04-08", 0.00, 0.00, 0, 0.00, 0.00, 0.00, 715471.90 ],
    "status" : "PAID"
  }, {
    "overdue" : "NOT_OVERDUE",
    "data" : [ 7, "2019-05-08", 0.00, 26740.46, 26740.46, 0.00, 26740.46, 0.00, 715471.90 ],
    "status" : "PAID"
  }, {
    "overdue" : "NOT_OVERDUE",
    "data" : [ 8, "2019-05-08", 116298.79, 7154.72, 7154.72, 116298.79, 7154.72, 0.00, 715471.90 ],
    "status" : "PAID"
  }, {
    "overdue" : "OVERDUE",
    "data" : [ 9, "2019-06-10", 117461.78, 5991.73, 0.00, 0.00, 0.00, 123453.51, 599173.11 ],
    "status" : "UNPAID"
  }, {
    "overdue" : "OVERDUE",
    "data" : [ 10, "2019-07-08", 118636.40, 4817.11, 0, 0.00, 0.00, 123453.51, 481711.33 ],
    "status" : "UNPAID"
  }, {
    "overdue" : "OVERDUE",
    "data" : [ 11, "2019-08-08", 119822.76, 3630.75, 0, 0.00, 0.00, 123453.51, 363074.93 ],
    "status" : "UNPAID"
  }, {
    "overdue" : "OVERDUE",
    "data" : [ 12, "2019-09-09", 121020.99, 2432.52, 0, 0.00, 0.00, 123453.51, 243252.17 ],
    "status" : "UNPAID"
  }, {
    "overdue" : "OVERDUE",
    "data" : [ 13, "2019-10-08", 122231.18, 1222.31, 0, 0.00, 0.00, 123453.49, 122231.18 ],
    "status" : "UNPAID"
  } ],
  "totals" : [ null, null, 1000000.00, 92764.04, 74669.62, 400826.89, 74669.62, 617267.53, null ]
}
"""
    When I rollback on 2019-05-08
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
    "data" : [ 3, "2019-01-14", 96258.23, 12175.95, 12175.95, 96258.23, 12175.95, 0.00, 811730.13 ],
    "status" : "PAID"
  }, {
    "overdue" : "NOT_OVERDUE",
    "data" : [ 4, "2019-02-12", 0.00, 0.00, 0, 0.00, 0.00, 0.00, 715471.90 ],
    "status" : "PAID"
  }, {
    "overdue" : "NOT_OVERDUE",
    "data" : [ 5, "2019-03-12", 0.00, 0.00, 0, 0.00, 0.00, 0.00, 715471.90 ],
    "status" : "PAID"
  }, {
    "overdue" : "NOT_OVERDUE",
    "data" : [ 6, "2019-04-08", 0.00, 0.00, 0, 0.00, 0.00, 0.00, 715471.90 ],
    "status" : "PAID"
  }, {
    "overdue" : "OVERDUE",
    "data" : [ 7, "2019-05-08", 0.00, 26740.46, 26740.46, 0.00, 0.00, 26740.46, 715471.90 ],
    "status" : "UNPAID"
  }, {
    "overdue" : "OVERDUE",
    "data" : [ 8, "2019-05-08", 116298.79, 7154.72, 7154.72, 0.00, 0.00, 123453.51, 715471.90 ],
    "status" : "UNPAID"
  }, {
    "overdue" : "OVERDUE",
    "data" : [ 9, "2019-06-10", 117461.78, 5991.73, 0.00, 0.00, 0.00, 123453.51, 599173.11 ],
    "status" : "UNPAID"
  }, {
    "overdue" : "OVERDUE",
    "data" : [ 10, "2019-07-08", 118636.40, 4817.11, 0, 0.00, 0.00, 123453.51, 481711.33 ],
    "status" : "UNPAID"
  }, {
    "overdue" : "OVERDUE",
    "data" : [ 11, "2019-08-08", 119822.76, 3630.75, 0, 0.00, 0.00, 123453.51, 363074.93 ],
    "status" : "UNPAID"
  }, {
    "overdue" : "OVERDUE",
    "data" : [ 12, "2019-09-09", 121020.99, 2432.52, 0, 0.00, 0.00, 123453.51, 243252.17 ],
    "status" : "UNPAID"
  }, {
    "overdue" : "OVERDUE",
    "data" : [ 13, "2019-10-08", 122231.18, 1222.31, 0, 0.00, 0.00, 123453.49, 122231.18 ],
    "status" : "UNPAID"
  } ],
  "totals" : [ null, null, 1000000.00, 92764.04, 74669.62, 284528.10, 40774.44, 767461.50, null ]
}
"""