@ImpactFinance
Feature: Early Total Repayment before 4 days

  Background: Log in as admin
    When I log in with username admin and password admin
    Then cloud should response with code 200

  Scenario: Early Partial Repayment before 4 days
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
      | scheduleType           | ANNUITY_TWO_MONTHLY      |
      | scheduleBasedType      | BY_MATURITY              |
      | amount                 | 1000000                  |
      | interestRate           | 18                       |
      | gracePeriod            | 0                        |
      | maturity               |                          |
      | maturityDate           | 2019-12-20               |
      | disbursementDate       | 2019-01-21               |
      | preferredRepaymentDate | 2019-02-21               |
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

    When I actualize created loan on 2019-02-21
    Then cloud should response with code 200
    And message should be Actualize loan started

    When I make NORMAL_REPAYMENT for 181895.52 on 2019-02-21
    Then cloud should response with code 200
    And request should be created
    And not appear in Maker/Checker tab

    When I actualize created loan on 2019-04-18
    Then cloud should response with code 200
    And message should be Actualize loan started

    When I make NORMAL_REPAYMENT for 350000 on 2019-04-18
    Then cloud should response with code 200
    And request should be created
    And not appear in Maker/Checker tab

    When I actualize created loan on 2019-08-21
    Then cloud should response with code 200
    And message should be Actualize loan started

    When I make NORMAL_REPAYMENT for 191975.59 on 2019-08-21
    Then cloud should response with code 200
    And request should be created
    And not appear in Maker/Checker tab

    When I actualize created loan on 2019-11-06
    Then cloud should response with code 200
    And message should be Actualize loan started

    When I make NORMAL_REPAYMENT for 364287.21 on 2019-11-06
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
        82094.14,
        82094.14,
        1000000.00,
        82094.14,
        0.00,
        null
    ],
    "rows": [
        {
            "overdue": "NOT_OVERDUE",
            "data": [
                1,
                "2019-02-21",
                166895.52,
                15000.00,
                15000.00,
                166895.52,
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
                "2019-04-22",
                156902.39,
                24993.13,
                24993.13,
                156902.39,
                24993.13,
                0.00,
                833104.48
            ],
            "status": "PAID"
        },
        {
            "overdue": "NOT_OVERDUE",
            "data": [
                3,
                "2019-04-22",
                166423.44,
                0.00,
                0,
                166423.44,
                0.00,
                0.00,
                676202.09
            ],
            "status": "PAID"
        },
        {
            "overdue": "NOT_OVERDUE",
            "data": [
                4,
                "2019-06-21",
                0.00,
                15038.47,
                15038.47,
                0.00,
                15038.47,
                0.00,
                509778.65
            ],
            "status": "PAID"
        },
        {
            "overdue": "NOT_OVERDUE",
            "data": [
                5,
                "2019-08-21",
                161643.76,
                15293.36,
                15293.36,
                161643.76,
                15293.36,
                0.00,
                509778.65
            ],
            "status": "PAID"
        },
        {
            "overdue": "NOT_OVERDUE",
            "data": [
                6,
                "2019-10-21",
                171451.47,
                10444.05,
                10444.05,
                171451.47,
                10444.05,
                0.00,
                348134.89
            ],
            "status": "PAID"
        },
        {
            "overdue": "NOT_OVERDUE",
            "data": [
                7,
                "2019-11-06",
                176683.42,
                1325.13,
                1325.13,
                176683.42,
                1325.13,
                0.00,
                176683.42
            ],
            "status": "PAID"
        },
        {
            "overdue": "NOT_OVERDUE",
            "data": [
                8,
                "2019-12-20",
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
