@WIP
@MakerChecker
Feature: Approve and reject pending requests

  Background: Log in as admin to approve or reject pending requests
    When I log in with username admin and password admin
    Then cloud should response with code 200

  Scenario: Approve or reject pending requests
    Given there are pending requests
    When I make operation with them
    Then requests should disappear