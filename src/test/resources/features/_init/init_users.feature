@Init
Feature: Initial users setup for further scenarios

  Background: Log in as admin to setup initial data
    When I log in with username Administrator and password admin
    Then cloud should response with code 200

  Scenario: Create new user with role Maker
    Given there is no user with username maker
    When I create new user with
      | username | password    | firstName | lastName | roleName | branchId | email             | phoneNumber   | address | idNumber   | position | statusType |
      | maker    | @penCBS2019 | Maker     | Maker    | Maker    | 1        | maker@example.com | +996312543210 | Bishkek | 1234567890 | maker    | ACTIVE     |
    Then cloud should response with code 200
    And user maker should appear in the system

  Scenario: Create new user with role Maker for user
    Given there is no user with username makerfu
    When I create new user with
      | username | password    | firstName | lastName | roleName       | branchId | email               | phoneNumber   | address | idNumber   | position       | statusType |
      | makerfu  | @penCBS2019 | Maker     | For user | Maker for user | 1        | makerfu@example.com | +996312543210 | Bishkek | 1234567890 | maker for user | ACTIVE     |
    Then cloud should response with code 200
    And user makerfu should appear in the system

  Scenario: Create new user with role Checker for user
    Given there is no user with username checkerfu
    When I create new user with
      | username  | password    | firstName | lastName | roleName         | branchId | email                 | phoneNumber   | address | idNumber   | position         | statusType |
      | checkerfu | @penCBS2019 | Checker   | For user | Checker for user | 1        | checkerfu@example.com | +996312543210 | Bishkek | 1234567890 | checker for user | ACTIVE     |
    Then cloud should response with code 200
    And user checkerfu should appear in the system

  Scenario: Create new user with role Checker
    Given there is no user with username checker
    When I create new user with
      | username | password    | firstName | lastName | roleName | branchId | email               | phoneNumber   | address | idNumber   | position | statusType |
      | checker  | @penCBS2019 | Checker   | Checker  | Checker  | 1        | checker@example.com | +996312012345 | Bishkek | 0123456789 | checker  | ACTIVE     |
    Then cloud should response with code 200
    And user checker should appear in the system

  Scenario: Create new user with role Maker and Checker at the same time
    Given there is no user with username makerchecker
    When I create new user with
      | username     | password    | firstName | lastName | roleName     | branchId | email             | phoneNumber   | address | idNumber   | position | statusType |
      | makerchecker | @penCBS2019 | Maker     | Checker  | MakerChecker | 1        | makerchecker@example.com | +996312543210 | Bishkek | 1234567890 | maker    | ACTIVE     |
    Then cloud should response with code 200
    And user makerchecker should appear in the system

  Scenario: Create new user with certain data
    Given there is no user with username serenity
    When I create new user with
      | username | password    | firstName | lastName | roleName  | branchId | email                | phoneNumber   | address | idNumber    | position  | statusType |
      | serenity | Serenity312 | Serenity  | Rest     | Test Role | 1        | serenity@opencbs.com | +996312543210 | Bishkek | 35167725321 | test user | ACTIVE     |
    Then cloud should response with code 200
    And user serenity should appear in the system

  Scenario: Create new user for password reset
    Given there is no user with username password
    When I create new user with
      | username | password    | firstName | lastName | roleName  | branchId | email              | phoneNumber   | address | idNumber    | position  | statusType |
      | password | Password123 | Reset     | Password | Test Role | 1        | bektur@opencbs.com | +996312543210 | Bishkek | 35167725321 | test user | ACTIVE     |
    Then cloud should response with code 200
    And user password should appear in the system