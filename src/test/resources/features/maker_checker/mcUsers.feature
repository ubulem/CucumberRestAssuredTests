@WIP
@MakerChecker
@Config
Feature: Check Maker-checker system permissions for users
  There are separate permissions for every entity under the system
  Maker can create or delete his own requests as well as
  checker can approve or reject only his ones

  Scenario: Create user request as one maker and try to reject as another
    When I log in with username maker and password @penCBS2019
    And I create new user with
      | username     | password    | firstName | lastName | roleName  | branchId | email  | phoneNumber   | address | idNumber    | position  | statusType |
      | usertodelete | OpenCBS2019 | User      | ToDelete | Test Role | 1        | random | +996312543210 | Bishkek | 35167725321 | test user | ACTIVE     |
    Then cloud should response with code 200
    And request should be created
    When I log in with username makerfu and password @penCBS2019
    And disapprove it
    Then cloud should response with code 200

  Scenario: Create and approve new user with random data
    When I log in with username maker and password @penCBS2019
    And I create new user with
      | username | password    | firstName | lastName | roleName  | branchId | email  | phoneNumber   | address | idNumber    | position  | statusType |
      | random   | OpenCBS2019 | random    | random   | Test Role | 1        | random | +996312543210 | Bishkek | 35167725321 | test user | ACTIVE     |
    Then cloud should response with code 200
    And request should be created
    When I log in with username checker and password @penCBS2019
    And approve it
    Then cloud should response with code 200
    And user random should appear in the system

  Scenario: Modify and approve user
    When I log in with username maker and password @penCBS2019
    And I change user with username serenity
      | username | firstName | lastName | roleName | branchId | email                | phoneNumber   | address | idNumber | position | statusType |
      | serenity | Ivan      | Ivanov   | admin    | 1        | serenity@example.com | +996776349348 | Bishkek | 22121987 | QA Lead  | ACTIVE     |
    Then cloud should response with code 200
    And request should be created

    And I change user with username serenity
      | username | firstName | lastName | roleName | branchId | email                | phoneNumber   | address | idNumber | position | statusType |
      | serenity | Ivan      | Ivanov   | admin    | 1        | serenity@example.com | +996776349348 | Bishkek | 22121987 | QA Lead  | ACTIVE     |
    Then cloud should response with code 500
    And error code should be internal_error
    And message should be This object has already active request!

    When I log in with username checker and password @penCBS2019
    And approve it
    Then cloud should response with code 200
    And user data should be modified respectively

  Scenario: Create a pending request of a new user
    When I log in with username maker and password @penCBS2019
    And I create new user with
      | username | password    | firstName | lastName | roleName  | branchId | email  | phoneNumber   | address | idNumber    | position  | statusType |
      | random   | OpenCBS2019 | random    | random   | Test Role | 1        | random | +996312543210 | Bishkek | 35167725321 | test user | ACTIVE     |
    Then cloud should response with code 200
    And request should be created
    And appear in Maker/Checker tab
    And user random shouldn't appear in the system