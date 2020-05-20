@Init
Feature: Initial penalties setup for further scenarios

  Background: Log in as admin to setup initial data
    When I log in with username Administrator and password admin
    Then cloud should response with code 200

  Scenario: Create initial penalties for loan products before 90 days
    Given there is no penalty with name Late principal fee 1
    When I create penalty
      | accrualAccountId  | 153                  |
      | beginPeriodDay    | 1                    |
      | endPeriodDay      | 90                   |
      | gracePeriod       | 15                   |
      | incomeAccountId   | 152                  |
      | name              | Late principal fee 1 |
      | penalty           | 0.03                 |
      | penaltyType       | BY_LATE_PRINCIPAL    |
      | writeOffAccountId | 140                  |
    Then cloud should response with code 200

  Scenario: Create initial penalties for loan products after 90 days
    Given there is no penalty with name Late principal fee 2
    When I create penalty
      | accrualAccountId  | 153                  |
      | beginPeriodDay    | 91                   |
      | endPeriodDay      | 365                  |
      | gracePeriod       | 0                   |
      | incomeAccountId   | 152                  |
      | name              | Late principal fee 2 |
      | penalty           | 0.05                 |
      | penaltyType       | BY_LATE_PRINCIPAL    |
      | writeOffAccountId | 140                  |
    Then cloud should response with code 200

    Given there is no penalty with name Late OLB fee
    When I create penalty
      | accrualAccountId  | 153          |
      | beginPeriodDay    | 1            |
      | endPeriodDay      | 90           |
      | gracePeriod       | 15           |
      | incomeAccountId   | 152          |
      | name              | Late OLB fee |
      | penalty           | 0.01         |
      | penaltyType       | BY_OLB       |
      | writeOffAccountId | 140          |
    Then cloud should response with code 200

    Given there is no penalty with name Late flat fee
    When I create penalty
      | accrualAccountId  | 153           |
      | beginPeriodDay    | 1             |
      | endPeriodDay      | 90            |
      | gracePeriod       | 15            |
      | incomeAccountId   | 152           |
      | name              | Late flat fee |
      | penalty           | 100           |
      | penaltyType       | FLAT          |
      | writeOffAccountId | 140           |
    Then cloud should response with code 200

    Given there is no penalty with name Late disbursement fee
    When I create penalty
      | accrualAccountId  | 153                    |
      | beginPeriodDay    | 1                      |
      | endPeriodDay      | 90                     |
      | gracePeriod       | 15                     |
      | incomeAccountId   | 152                    |
      | name              | Late disbursement fee  |
      | penalty           | 0.01                   |
      | penaltyType       | BY_DISBURSEMENT_AMOUNT |
      | writeOffAccountId | 140                    |
    Then cloud should response with code 200

    Given there is no penalty with name Late interest fee
    When I create penalty
      | accrualAccountId  | 153               |
      | beginPeriodDay    | 1                 |
      | endPeriodDay      | 90                |
      | gracePeriod       | 15                |
      | incomeAccountId   | 152               |
      | name              | Late interest fee |
      | penalty           | 0.01              |
      | penaltyType       | BY_LATE_INTEREST  |
      | writeOffAccountId | 140               |
    Then cloud should response with code 200
