@javascript
Feature: Subscribe

  In order to gain calendar tenancy
  As a visitor
  I want to start an account subscription

  Scenario: Subscribing
    Given I am not logged in
    When I visit the home page
    And I visit the subscription page
    And I fill in my credit information
    Then I should see the new subscription welcome
