@ImpactFinance
Feature: Early Total Repayment with shifted days

  Background: Log in as admin
    When I log in with username admin and password admin
    Then cloud should response with code 200

  Scenario: Early Total Repayment with shifted days
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
      | maturityDate           | 2019-11-26               |
      | disbursementDate       | 2018-11-26               |
      | preferredRepaymentDate | 2018-12-26               |
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

    When I actualize created loan on 2018-12-26
    Then cloud should response with code 200
    And message should be Actualize loan started

    When I make NORMAL_REPAYMENT for 91679.99 on 2018-12-26
    Then cloud should response with code 200
    And request should be created
    And not appear in Maker/Checker tab

    When I actualize created loan on 2019-01-28
    Then cloud should response with code 200
    And message should be Actualize loan started

    When I make NORMAL_REPAYMENT for 954942.01 on 2019-01-28
    Then cloud should response with code 200
    And request should be created
    And not appear in Maker/Checker tab
    And schedule should like this
"""
{
    "types": [
        "INTEGER",
        "DATE",
        "DECIMAL",
        "DECIMAL",
        "DECIMAL",
        "DECIMAL",
        "DECIMAL",
        "DECIMAL",
        "DECIMAL"
    ],
    "columns": [
        "#",
        "Payment Date",
        "Principal",
        "Interest",
        "Accrued Interest",
        "Paid Principal",
        "Paid Interest",
        "Total",
        "Planned OLB"
    ],
    "totals": [
        null,
        null,
        1000000.00,
        29695.29,
        29695.29,
        1000000.00,
        29695.29,
        0.00,
        null
    ],
    "rows": [
        {
            "overdue": "NOT_OVERDUE",
            "data": [
                1,
                "2018-12-26",
                76679.99,
                15000.00,
                15000.00,
                76679.99,
                15000.00,
                0.00,
                1000000.00
            ],
            "status": "PAID"
        },
        {
            "overdue": "NOT_OVERDUE",
            "data": [
                2,
                "2019-01-28",
                77830.19,
                13849.80,
                13849.80,
                77830.19,
                13849.80,
                0.00,
                923320.01
            ],
            "status": "PAID"
        },
        {
            "overdue": "NOT_OVERDUE",
            "data": [
                3,
                "2019-01-28",
                845489.82,
                845.49,
                845.49,
                845489.82,
                845.49,
                0.00,
                845489.82
            ],
            "status": "PAID"
        },
        {
            "overdue": "NOT_OVERDUE",
            "data": [
                4,
                "2019-02-26",
                0.00,
                0.00,
                0,
                0.00,
                0.00,
                0.00,
                0.00
            ],
            "status": "PAID"
        },
        {
            "overdue": "NOT_OVERDUE",
            "data": [
                5,
                "2019-03-26",
                0.00,
                0.00,
                0,
                0.00,
                0.00,
                0.00,
                0.00
            ],
            "status": "PAID"
        },
        {
            "overdue": "NOT_OVERDUE",
            "data": [
                6,
                "2019-04-26",
                0.00,
                0.00,
                0,
                0.00,
                0.00,
                0.00,
                0.00
            ],
            "status": "PAID"
        },
        {
            "overdue": "NOT_OVERDUE",
            "data": [
                7,
                "2019-05-27",
                0.00,
                0.00,
                0,
                0.00,
                0.00,
                0.00,
                0.00
            ],
            "status": "PAID"
        },
        {
            "overdue": "NOT_OVERDUE",
            "data": [
                8,
                "2019-06-26",
                0.00,
                0.00,
                0,
                0.00,
                0.00,
                0.00,
                0.00
            ],
            "status": "PAID"
        },
        {
            "overdue": "NOT_OVERDUE",
            "data": [
                9,
                "2019-07-26",
                0.00,
                0.00,
                0,
                0.00,
                0.00,
                0.00,
                0.00
            ],
            "status": "PAID"
        },
        {
            "overdue": "NOT_OVERDUE",
            "data": [
                10,
                "2019-08-26",
                0.00,
                0.00,
                0,
                0.00,
                0.00,
                0.00,
                0.00
            ],
            "status": "PAID"
        },
        {
            "overdue": "NOT_OVERDUE",
            "data": [
                11,
                "2019-09-26",
                0.00,
                0.00,
                0,
                0.00,
                0.00,
                0.00,
                0.00
            ],
            "status": "PAID"
        },
        {
            "overdue": "NOT_OVERDUE",
            "data": [
                12,
                "2019-10-28",
                0.00,
                0.00,
                0,
                0.00,
                0.00,
                0.00,
                0.00
            ],
            "status": "PAID"
        },
        {
            "overdue": "NOT_OVERDUE",
            "data": [
                13,
                "2019-11-26",
                0.00,
                0.00,
                0,
                0.00,
                0.00,
                0.00,
                0.00
            ],
            "status": "PAID"
        }
    ]
}
"""