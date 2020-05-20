@Contracts
@WIP
Feature: Operations with term deposit accounts
  In order to work with term deposit
  I create term deposit account
  and go through opening process

  Background: Log in as admin
    When I log in with username admin and password admin
    Then cloud should response with code 200

  Scenario: Operations with term deposit accounts
  Create and open term deposit account
    Given there is a term deposit product with id 1
    And there is a profile with id 4
    When I create term deposit for this person with parameters
      | termDepositProductId | 1                   |
      | interestRate         | 8                   |
      | serviceOfficerId     | 2                   |
      | profileId            | 4                   |
      | earlyCloseFeeRate    | 0                   |
      | earlyCloseFeeFlat    | 0                   |
      | termAgreement        | 12                  |
      | createdDate          | 2019-04-16T11:00:00 |
    Then cloud should response with code 200

    When I get current accounts for person with id 4
    And I create transaction with parameters
      | amount          | 100000                         |
      | createdAt       | 2019-01-30T10:00:00            |
      | debitAccountId  | 140                            |
      | creditAccountId | -1                             |
      | description     | Initial payment for Bill Gates |
      | autoPrint       | false                          |
    Then cloud should response with code 200
    And account balance must be 100000.0

    When I open term deposit with amount 100000 on date 2019-04-16T11:00:00
    Then cloud should response with code 200

    When I actualize created term deposit on today
    Then cloud should response with code 200
    And message should be Actualize term deposit started