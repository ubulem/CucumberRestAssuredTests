@WIP
@MakerChecker
@Profiles
Feature: Check Maker-checker system permissions for companies
  There are separate permissions for every entity under the system
  Maker can create or delete his own requests as well as
  checker can approve or reject only his ones

  Scenario Outline: Create and approve two new random companies
    When I log in with username maker and password @penCBS2019
    And I create new company with
      | 4 | <name>     |
      | 5 | <business> |
    Then cloud should response with code 200
    And request should be created
    When I log in with username checker and password @penCBS2019
    And approve it
    Then cloud should response with code 200
    And the company should be created

    Examples:
      | name   | business |
      | random | random   |
      | random | random   |

  Scenario: Create and disapprove the company
    When I log in with username maker and password @penCBS2019
    And I create new company with
      | 4 | CompanyToDelete |
      | 5 | 1               |
    Then cloud should response with code 200
    And request should be created
    When I log in with username checker and password @penCBS2019
    And disapprove it
    Then cloud should response with code 200

  Scenario: Create a pending request of the company
    When I log in with username maker and password @penCBS2019
    And I create new company with
      | 4 | random |
      | 5 | random |
    Then cloud should response with code 200
    And request should be created
    And appear in Maker/Checker tab

  Scenario: Update and approve company
    Given there is a company with id 6
    When I log in with username maker and password @penCBS2019
    And I change company data with id 6 to
      | 4 | OpenCBS |
      | 5 | 2       |
    Then cloud should response with code 200
    And request should be created
    When I change company data with id 6 to
      | 4 | OpenCBS |
      | 5 | 2       |
    Then cloud should response with code 500
    And error code should be internal_error
    And message should be This object has already active request!
    When I log in with username checker and password @penCBS2019
    And approve it
    Then cloud should response with code 200
    And company name should be respectively changed