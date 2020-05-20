@WIP
@Config
Feature: Operations with locations
  In order to work with locations
  I create and edit them via configuration

  Background: Log in as admin to setup initial data
    When I log in with username admin and password admin
    Then cloud should response with code 200

  Scenario: Create a random location
    When I create location random
    Then cloud should response with code 200

  Scenario: Create a location with existing name
    Given there is a location with name Kyrgyzstan
    When I create location Kyrgyzstan
    Then cloud should response with code 400
    And error code should be invalid
    And message should be Name is taken.

  Scenario: Modify a location
    Given there is a location with name Kyrgyzstan
    And there is no location with name Kyrgyz Republic
    When I change location Kyrgyzstan to Kyrgyz Republic
    Then cloud should response with code 200
    And location name should be changed to Kyrgyz Republic