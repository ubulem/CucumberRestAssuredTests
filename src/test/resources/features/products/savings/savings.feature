@Contracts
@WIP
Feature: Operations with savings accounts
  In order to work with savings
  I create savings account
  and go through opening process

  Background: Log in as admin
    When I log in with username admin and password admin
    Then cloud should response with code 200

  Scenario: Operations with savings accounts
  Create and open savings account with non-standard schedule
    Given there is a saving product with id 1
    And there is a profile with id 3
    When I create savings for this person with parameters
      | closeFeeFlat      | 0                   |
      | closeFeeRate      | 0                   |
      | depositFeeFlat    | 0                   |
      | depositFeeRate    | 0                   |
      | entryFeeFlat      | 0                   |
      | entryFeeRate      | 0                   |
      | interestRate      | 10                  |
      | managementFeeFlat | 0                   |
      | managementFeeRate | 0                   |
      | openDate          | 2019-06-17T15:00:37 |
      | profileId         | 3                   |
      | savingOfficerId   | 2                   |
      | savingProductId   | 1                   |
      | withdrawalFeeFlat | 0                   |
      | withdrawalFeeRate | 0                   |
    Then cloud should response with code 200

    When I get current accounts for person with id 3
    And I create transaction with parameters
      | amount          | 150000                         |
      | createdAt       | 2019-01-12T14:57:58            |
      | debitAccountId  | 140                            |
      | creditAccountId | -1                             |
      | description     | Initial payment for Steve Jobs |
      | autoPrint       | false                          |
    Then cloud should response with code 200

    When I open savings with amount 150000
    Then cloud should response with code 200

    When I actualize created savings on today
    Then cloud should response with code 200
    And message should be Actualize saving started

  Scenario: Operations with savings accounts
  Create and open savings account with standard schedule
    Given there is a saving product with id 2
    And there is a profile with id 5
    When I create savings for this person with parameters
      | closeFeeFlat      | 0                   |
      | closeFeeRate      | 0                   |
      | depositFeeFlat    | 0                   |
      | depositFeeRate    | 0                   |
      | entryFeeFlat      | 0                   |
      | entryFeeRate      | 0                   |
      | interestRate      | 10                  |
      | managementFeeFlat | 0                   |
      | managementFeeRate | 0                   |
      | openDate          | 2019-06-28T15:00:37 |
      | profileId         | 5                   |
      | savingOfficerId   | 2                   |
      | savingProductId   | 1                   |
      | withdrawalFeeFlat | 0                   |
      | withdrawalFeeRate | 0                   |
    Then cloud should response with code 200

    When I get current accounts for person with id 5
    And I create transaction with parameters
      | amount          | 100000                            |
      | createdAt       | 2019-04-10T14:57:58               |
      | debitAccountId  | 140                               |
      | creditAccountId | -1                                |
      | description     | Initial payment for Larry Ellison |
      | autoPrint       | false                             |
    Then cloud should response with code 200

    When I open savings with amount 100000
    Then cloud should response with code 200

    When I actualize created savings on today
    Then cloud should response with code 200
    And message should be Actualize saving started