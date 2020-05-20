@WIP
@Config
Feature: Operations with users
  In order to work with system
  I create new users or modify existing ones

  Scenario: Create new active user
    When I log in with username makerchecker and password @penCBS2019
    And I create new user with
      | username | password    | firstName | lastName | roleName  | branchId | email  | phoneNumber   | address | idNumber    | position  | statusType |
      | random   | OpenCBS2019 | random    | random   | Test Role | 1        | random | +996312543210 | Bishkek | 35167725321 | test user | ACTIVE     |
    Then cloud should response with code 200
    And request should be created
    And not appear in Maker/Checker tab
    And user random should appear in the system

  Scenario: Create new inactive user
    When I log in with username makerchecker and password @penCBS2019
    And I create new user with
      | username | password    | firstName | lastName | roleName  | branchId | email  | phoneNumber   | address | idNumber    | position  | statusType |
      | random   | OpenCBS2019 | random    | random   | Test Role | 1        | random | +996312543210 | Bishkek | 35167725321 | test user | INACTIVE   |
    Then cloud should response with code 200
    And request should be created
    And not appear in Maker/Checker tab
    And user random shouldn't appear in the system
    When I click Show all button on USERS page
    Then user random should appear in the list

  Scenario: Create a user with existing username
    Given there is a user with username admin
    When I log in with username makerchecker and password @penCBS2019
    And I create new user with
      | username | password    | firstName | lastName | roleName | branchId | email            | phoneNumber   | address | idNumber    | position  | statusType |
      | admin    | OpenCBS2019 | Rest      | Assured  | admin    | 1        | test@opencbs.com | +996778028726 | Bishkek | 35167725321 | test user | ACTIVE     |
    Then cloud should response with code 400
    And error code should be invalid
    And message should be This username is taken.

  Scenario: Create a username with a uppercase letters
    Given there is no user with username UpperUsername
    When I log in with username makerchecker and password @penCBS2019
    And I create new user with
      | username      | password    | firstName | lastName | roleName | branchId | email          | phoneNumber  | address | idNumber    | position  | statusType |
      | UpperUsername | OpenCBS2019 | Upper     | Username | admin    | 1        | test@gmail.com | +12124352453 | Bishkek | 35167725321 | test user | ACTIVE     |
    Then cloud should response with code 200
    And request should be created
    And not appear in Maker/Checker tab
    And user UpperUsername should appear in the system

  Scenario: Create a user with incorrect username
    When I log in with username makerchecker and password @penCBS2019
    And I create new user with
      | username    | password    | firstName | lastName | roleName | branchId | email            | phoneNumber   | address | idNumber    | position  | statusType |
      | hello world | OpenCBS2019 | Rest      | Assured  | admin    | 1        | test@opencbs.com | +996778028726 | Bishkek | 35167725321 | test user | ACTIVE     |
    Then cloud should response with code 400
    And error code should be invalid
    And message should be Username is not correct

  Scenario: Modify the user
    When I log in with username makerchecker and password @penCBS2019
    And I change user with username serenity
      | username | firstName | lastName | roleName | branchId | email              | phoneNumber   | address | idNumber | position | statusType |
      | serenity | John      | Doe      | admin    | 1        | petrov@example.com | +996776349348 | Bishkek | 22121987 | QA Lead  | ACTIVE     |
    Then cloud should response with code 200
    And request should be created
    And not appear in Maker/Checker tab
    And user data should be modified respectively