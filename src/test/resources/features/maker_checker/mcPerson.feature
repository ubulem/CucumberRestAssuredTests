@WIP
@MakerChecker
@Profiles
Feature: Check Maker-checker system permissions for profiles
  There are separate permissions for every entity under the system
  Maker can create or delete his own requests as well as
  checker can approve or reject only his ones

  Scenario Outline: Create and approve two new random persons
    When I log in with username maker and password @penCBS2019
    And I create new person with
      | 1 | <firstName> |
      | 2 | <lastName>  |
      | 3 | 1979-02-25  |
    Then cloud should response with code 200
    And request should be created
    When I log in with username checker and password @penCBS2019
    And approve it
    Then cloud should response with code 200
    And the person should be created

    Examples:
      | firstName | lastName |
      | random    | random   |
      | random    | random   |

  Scenario: Create and disapprove the person
    When I log in with username maker and password @penCBS2019
    And I create new person with
      | 1 | Person     |
      | 2 | ToDelete   |
      | 3 | 1979-02-25 |
    Then cloud should response with code 200
    And request should be created
    When I log in with username checker and password @penCBS2019
    And disapprove it
    Then cloud should response with code 200

  Scenario: Create a pending request of a person
    When I log in with username maker and password @penCBS2019
    And I create new person with
      | 1 | random     |
      | 2 | random     |
      | 3 | 1979-02-25 |
    Then cloud should response with code 200
    And request should be created
    And appear in Maker/Checker tab

  Scenario: Update and approve a person
    Given there is a profile with id 1
    When I log in with username maker and password @penCBS2019
    And I change person data with id 1 to
      | 1 | Serenity   |
      | 2 | Rest       |
      | 3 | 1987-05-30 |
    Then cloud should response with code 200
    And request should be created
    When I change person data with id 1 to
      | 1 | Serenity   |
      | 2 | Rest       |
      | 3 | 1987-05-30 |
    Then cloud should response with code 500
    And error code should be internal_error
    And message should be This object has already active request!
    When I log in with username checker and password @penCBS2019
    And approve it
    Then cloud should response with code 200
    And person name should be changed to Serenity Rest
