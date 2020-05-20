@ImpactFinance
Feature: Early Total Repayment for Impact Finance

  Background: Log in as admin
    When I log in with username admin and password admin
    Then cloud should response with code 200

  Scenario: Early Total Repayment for Impact Finance
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

    When I actualize created loan on 2019-01-02
    Then cloud should response with code 200
    And message should be Actualize loan started

    When I make NORMAL_REPAYMENT for 836244.38 on 2019-01-02
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
        36715.79,
        36715.79,
        1000000.00,
        36715.79,
        0.00,
        null
    ],
    "rows": [
        {
            "overdue": "NOT_OVERDUE",
            "data": [
                1,
                "2018-11-12",
                93434.18,
                15000.00,
                15000.00,
                93434.18,
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
                "2018-12-12",
                94835.69,
                13598.49,
                13598.49,
                94835.69,
                13598.49,
                0.00,
                906565.82
            ],
            "status": "PAID"
        },
        {
            "overdue": "NOT_OVERDUE",
            "data": [
                3,
                "2019-01-02",
                811730.13,
                8117.30,
                8117.30,
                811730.13,
                8117.30,
                0.00,
                811730.13
            ],
            "status": "PAID"
        },
        {
            "overdue": "NOT_OVERDUE",
            "data": [
                4,
                "2019-01-14",
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
                "2019-02-12",
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
                "2019-03-12",
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
                "2019-04-12",
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
                "2019-05-13",
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
                "2019-06-12",
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
                "2019-07-12",
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
                "2019-08-12",
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