@ImpactFinance
Feature: Early Partial Repayment for Impact Finance

  Background: Log in as admin
    When I log in with username admin and password admin
    Then cloud should response with code 200

  Scenario: Early Partial Repayment for Impact Finance
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

    When I actualize created loan on 2018-12-03
    Then cloud should response with code 200
    And message should be Actualize loan started

    When I make NORMAL_REPAYMENT for 350000 on 2018-12-03
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
        76282.10,
        24518.94,
        430415.24,
        24518.94,
        621347.92,
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
                "2018-12-03",
                336981.06,
                9518.94,
                9518.94,
                336981.06,
                9518.94,
                0.00,
                906565.82
            ],
            "status": "PAID"
        },
        {
            "overdue": "OVERDUE",
            "data": [
                3,
                "2018-12-12",
                0.00,
                2563.13,
                0,
                0.00,
                0.00,
                2563.13,
                569584.76
            ],
            "status": "UNPAID"
        },
        {
            "overdue": "OVERDUE",
            "data": [
                4,
                "2019-01-14",
                0.00,
                8543.77,
                0,
                0.00,
                0.00,
                8543.77,
                569584.76
            ],
            "status": "UNPAID"
        },
        {
            "overdue": "OVERDUE",
            "data": [
                5,
                "2019-02-12",
                0.00,
                8543.77,
                0,
                0.00,
                0.00,
                8543.77,
                569584.76
            ],
            "status": "UNPAID"
        },
        {
            "overdue": "OVERDUE",
            "data": [
                6,
                "2019-03-12",
                50982.59,
                8543.77,
                0,
                0.00,
                0.00,
                59526.36,
                569584.76
            ],
            "status": "UNPAID"
        },
        {
            "overdue": "OVERDUE",
            "data": [
                7,
                "2019-04-12",
                100655.15,
                7779.03,
                0,
                0.00,
                0.00,
                108434.18,
                518602.17
            ],
            "status": "UNPAID"
        },
        {
            "overdue": "OVERDUE",
            "data": [
                8,
                "2019-05-13",
                102164.97,
                6269.21,
                0,
                0.00,
                0.00,
                108434.18,
                417947.02
            ],
            "status": "UNPAID"
        },
        {
            "overdue": "OVERDUE",
            "data": [
                9,
                "2019-06-12",
                103697.45,
                4736.73,
                0,
                0.00,
                0.00,
                108434.18,
                315782.05
            ],
            "status": "UNPAID"
        },
        {
            "overdue": "OVERDUE",
            "data": [
                10,
                "2019-07-12",
                105252.91,
                3181.27,
                0,
                0.00,
                0.00,
                108434.18,
                212084.60
            ],
            "status": "UNPAID"
        },
        {
            "overdue": "OVERDUE",
            "data": [
                11,
                "2019-08-12",
                106831.69,
                1602.48,
                0,
                0.00,
                0.00,
                108434.17,
                106831.69
            ],
            "status": "UNPAID"
        }
    ]
}
"""
