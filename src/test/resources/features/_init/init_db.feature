@Init
Feature: Init specific settings for ImpactFinance database

  Background: Log in as Administrator to setup own admin user
    When I log in with username Administrator and password admin
    Then cloud should response with code 200

  Scenario: Update account 'validate_off' property
    When I set validate off on accrued interest account
    Then it should change