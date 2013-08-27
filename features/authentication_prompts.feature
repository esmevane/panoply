Feature: Authentication Prompts

  In order to negotiate the site painlessly
  As a visitor
  I want to see authentication prompts where appropriate

  Scenario: Login or sign up on home page
    Given I am not logged in
    When I visit the home page
    Then I should see the login / sign up prompt

  Scenario: No prompt on home page if signed in
    Given I am logged in
    When I visit the home page
    Then I should not see the login / sign up prompt
