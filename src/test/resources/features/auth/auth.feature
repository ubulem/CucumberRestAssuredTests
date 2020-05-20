@Auth
Feature: Authentication
  In order to work with software
  I go to dedicated website
  and log in with given username and password

  Scenario: Log in as admin
    When I log in with username admin and password admin
    Then cloud should response with code 200

  Scenario: Log in with incorrect credentials
    When I log in with username admin and password qwerty
    Then cloud should response with code 404
    And error code should be Not Found
    And message should be Incorrect username or password.

  Scenario: Log in under the certain user (not admin)
    When I log in with username serenity and password Serenity312
    Then cloud should response with code 200

  Scenario: Reset password for existing username
    When user password clicks "Forgot your password" button
    Then cloud should response with code 200
    And message should be Check your email.

  Scenario: Reset password for non-existing username
    When user user404 clicks "Forgot your password" button
    Then cloud should response with code 404
    And error code should be Not Found
    And message should be User is not found (Username = user404).