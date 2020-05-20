@Init
Feature: Create your own admin for further actions

  Background: Log in as Administrator to setup own admin user
    When I log in with username Administrator and password admin
    Then cloud should response with code 200

  Scenario: Create the admin role
    Given there is no role with name admin
    When I create role with name admin and status ACTIVE and all permissions
    Then cloud should response with code 200
    And role admin should appear in the system

  Scenario: Create the own admin user
    Given there is no user with username admin
    When I create new user with
      | username | password | firstName | lastName | roleName | branchId | email             | phoneNumber   | address | idNumber   | position | statusType |
      | admin    | admin    | Jon       | Snow     | admin    | 1        | admin@example.com | +996312543210 | Bishkek | 1234567890 | admin    | ACTIVE     |
    Then cloud should response with code 200
    And user admin should appear in the system