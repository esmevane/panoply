Feature: Tenancy

  In order to allow many organizations to use Panoply
  As an application provider
  I want to allow organization tenancy

  Scenario: Visiting an occupied tenant
    Given the tenant Fiddlehead Fern
    When I visit the Fiddlehead Fern home page
    Then I should see the Fiddlehead Fern calendar

  Scenario: Visiting a vacant tenant
    Given I have no tenants
    When I visit the Fiddlehead Fern home page
    Then I should see the standard application greeting
    And I should not see the Fiddlehead Fern path