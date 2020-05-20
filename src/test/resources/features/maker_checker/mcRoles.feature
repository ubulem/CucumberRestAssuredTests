@WIP
@MakerChecker
@Config
Feature: Check Maker-checker system permissions for roles
  There are separate permissions for every entity under the system
  Maker can create or delete his own requests as well as
  checker can approve or reject only his ones

  Scenario: Create and reject a request of a role
    Given there is no role with name RoleToDelete
    When I log in with username maker and password @penCBS2019
    And I create role with name RoleToDelete and status ACTIVE and permissions
      | MAKER_FOR_ROLE | MAKER_FOR_LOAN_PRODUCT | MAKER_FOR_SAVING_PRODUCT | MAKER_FOR_USER |
    Then cloud should response with code 200
    And request should be created
    And disapprove it
    Then cloud should response with code 200
    And role RoleToDelete shouldn't appear in the system

  Scenario: Create and approve a random role
    When I log in with username maker and password @penCBS2019
    And I create role with name random and status ACTIVE and permissions
      | MAKER_FOR_ROLE | MAKER_FOR_LOAN_PRODUCT | MAKER_FOR_SAVING_PRODUCT | MAKER_FOR_USER | CHECKER_FOR_ROLE | CHECKER_FOR_LOAN_PRODUCT | CHECKER_FOR_SAVING_PRODUCT | CHECKER_FOR_USER |
    Then cloud should response with code 200
    And request should be created
    When I log in with username checker and password @penCBS2019
    And approve it
    Then cloud should response with code 200
    And role random should appear in the system

  Scenario: Modify and approve a role
    Given there is a role with name Test Role
    When I log in with username maker and password @penCBS2019
    And I modify role with name Test Role with the following set of permissions
      | GET_LOANS_APPLICATIONS | SUBMIT_LOANS_APPLICATIONS | CHANGE_STATUS_OF_LOANS_APPLICATIONS | CREATE_LOAN_APPLICATION | UPDATE_LOANS_APPLICATIONS | OTHER_FEE_WAIVE_OFF | LOAN_WRITE_OFF |
    Then cloud should response with code 200
    And request should be created

    And I modify role with name Test Role with the following set of permissions
      | GET_LOANS_APPLICATIONS | SUBMIT_LOANS_APPLICATIONS | CHANGE_STATUS_OF_LOANS_APPLICATIONS | CREATE_LOAN_APPLICATION | UPDATE_LOANS_APPLICATIONS | OTHER_FEE_WAIVE_OFF | LOAN_WRITE_OFF |
    Then cloud should response with code 500
    And error code should be internal_error
    And message should be This object has already active request!

    When I log in with username checker and password @penCBS2019
    And approve it
    Then cloud should response with code 200

  Scenario: Create a pending request of a new role
    When I log in with username maker and password @penCBS2019
    And I create role with name random and status ACTIVE and permissions
      | MAKER_FOR_ROLE | MAKER_FOR_LOAN_PRODUCT | MAKER_FOR_SAVING_PRODUCT | MAKER_FOR_USER |
    Then cloud should response with code 200
    And request should be created
    And appear in Maker/Checker tab
    And role random shouldn't appear in the system