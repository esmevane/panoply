Feature: Calendar

  In order to request an appointment
  As a visitor
  I want to use the booking calendar

  Scenario: Visiting a tenant's calendar
    Given the tenant Fiddlehead Fern
    When I visit the Fiddlehead Fern calendar
    Then I should see the appointment calendar

  Scenario: Visiting an unoccupied tenant calendar
    Given I have no tenants
    When I visit the Fiddlehead Fern calendar
    Then I should not see the appointment calendar
    And I should see the standard application greeting

  Scenario: Seeing therapists on the calendar
    Given I have the tenant Fiddlehead Fern with members:
      | name    |
      | Talina  |
      | Jesse   |
      | Amanda  |
    When I visit the Fiddlehead Fern calendar
    Then I should see the names:
      | name    |
      | Talina  |
      | Jesse   |
      | Amanda  |

  Scenario: Seeing time slots on the calendar
    Given I have the tenant Fiddlehead Fern with members:
      | name    |
      | Talina  |
      | Jesse   |
      | Amanda  |
    And they each have one 6-hour time slot today
    When I visit the Fiddlehead Fern calendar
    Then I should see three time slots
