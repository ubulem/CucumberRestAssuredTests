@WIP
@MakerChecker
@Profiles
Feature: Check Maker-checker system permissions for groups
  There are separate permissions for every entity under the system
  Maker can create or delete his own requests as well as
  checker can approve or reject only his ones

  Scenario Outline: Create and approve two new random groups
    When I log in with username maker and password @penCBS2019
    And I create new group with
      | 1 | <name> |
    Then cloud should response with code 200
    And request should be created
    When I log in with username checker and password @penCBS2019
    And approve it
    Then cloud should response with code 200
    And the group should be created

    Examples:
      | name   |
      | random |
      | random |

  Scenario: Create and disapprove the group
    When I log in with username maker and password @penCBS2019
    And I create new group with
      | 1 | GroupToDelete |
    Then cloud should response with code 200
    And request should be created
    When I log in with username checker and password @penCBS2019
    And disapprove it
    Then cloud should response with code 200

  Scenario: Create a pending request of a group
    When I log in with username maker and password @penCBS2019
    And I create new group with
      | 1 | random |
    Then cloud should response with code 200
    And request should be created
    And appear in Maker/Checker tab

  Scenario: Update and approve a group
    Given there is a group with id 7
    When I log in with username maker and password @penCBS2019
    And I change group data with id 7 to
      | 1 | Alibaba |
    Then cloud should response with code 200
    And request should be created
    When I change group data with id 7 to
      | 1 | Alibaba |
    Then cloud should response with code 500
    And error code should be internal_error
    And message should be This object has already active request!
    When I log in with username checker and password @penCBS2019
    And approve it
    Then cloud should response with code 200
    And group name should be respectively changed