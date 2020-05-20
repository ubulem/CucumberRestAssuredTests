@WIP
@Init
Feature: Initial roles setup for further scenarios

  Background: Log in as admin to setup initial data
    When I log in with username Administrator and password admin
    Then cloud should response with code 200

  Scenario: Create the test role
    Given there is no role with name Test Role
    When I create role with name Test Role and status ACTIVE and permissions
      | GET_LOANS_APPLICATIONS | SUBMIT_LOANS_APPLICATIONS | CHANGE_STATUS_OF_LOANS_APPLICATIONS | CREATE_LOAN_APPLICATION | UPDATE_LOANS_APPLICATIONS |
    Then cloud should response with code 200
    And role Test Role should appear in the system

  Scenario: Create the Maker/checker role
    Given there is no role with name MakerChecker
    When I create role with name MakerChecker and status ACTIVE and permissions
      | CHECKER_FOR_GROUP | MAKER_FOR_GROUP | MAKER_FOR_COMPANY | CHECKER_FOR_COMPANY | CHECKER_FOR_PEOPLE | MAKER_FOR_PEOPLE | MAKER_FOR_ROLE | MAKER_FOR_LOAN_PRODUCT | MAKER_FOR_SAVING_PRODUCT | MAKER_FOR_TERM_DEPOSIT_PRODUCT | MAKER_FOR_USER | MAKER_FOR_ACCOUNT | MAKER_FOR_LOAN_DISBURSEMENT | MAKER_FOR_LOAN_REPAYMENT | MAKER_FOR_LOAN_ROLLBACK | CHECKER_FOR_ROLE | CHECKER_FOR_LOAN_PRODUCT | CHECKER_FOR_SAVING_PRODUCT | CHECKER_FOR_USER | CHECKER_FOR_ACCOUNT | CHECKER_FOR_LOAN_DISBURSEMENT | CHECKER_FOR_LOAN_REPAYMENT | CHECKER_FOR_LOAN_ROLLBACK |
    Then cloud should response with code 200
    And role MakerChecker should appear in the system

  Scenario: Create the checker role
    Given there is no role with name Checker
    When I create role with name Checker and status ACTIVE and permissions
      | CHECKER_FOR_GROUP | CHECKER_FOR_COMPANY | CHECKER_FOR_PEOPLE | CHECKER_FOR_ROLE | CHECKER_FOR_LOAN_PRODUCT | CHECKER_FOR_SAVING_PRODUCT | CHECKER_FOR_TERM_DEPOSIT_PRODUCT | CHECKER_FOR_USER | CHECKER_FOR_ACCOUNT | CHECKER_FOR_LOAN_DISBURSEMENT | CHECKER_FOR_LOAN_REPAYMENT | CHECKER_FOR_LOAN_ROLLBACK | GET_LOANS_APPLICATIONS | CONFIGURATIONS |
    Then cloud should response with code 200
    And role Checker should appear in the system

  Scenario: Create the maker role
    Given there is no role with name Maker
    When I create role with name Maker and status ACTIVE and permissions
      | MAKER_FOR_GROUP | MAKER_FOR_COMPANY | MAKER_FOR_PEOPLE | PAST_REPAYMENTS | ACTUALIZE_LOAN | GET_LOANS_APPLICATIONS | CONFIGURATIONS | MAKER_FOR_ROLE | MAKER_FOR_LOAN_PRODUCT | MAKER_FOR_SAVING_PRODUCT | MAKER_FOR_TERM_DEPOSIT_PRODUCT | MAKER_FOR_USER | MAKER_FOR_ACCOUNT | MAKER_FOR_LOAN_DISBURSEMENT | MAKER_FOR_LOAN_REPAYMENT | MAKER_FOR_LOAN_ROLLBACK |
    Then cloud should response with code 200
    And role Maker should appear in the system

  Scenario: Create the Maker for users only role
    Given there is no role with name Maker for user
    When I create role with name Maker for user and status ACTIVE and permissions
      | MAKER_FOR_USER |
    Then cloud should response with code 200
    And role Maker for user should appear in the system

  Scenario: Create the Checker for users only role
    Given there is no role with name Checker for user
    When I create role with name Checker for user and status ACTIVE and permissions
      | CHECKER_FOR_USER |
    Then cloud should response with code 200
    And role Checker for user should appear in the system