Feature: Sending Appointment Requests

  In order to send appointment requests
  As a visitor
  I want to use the booking calendar

  Background:
    Given I have a tenant with available time

  Scenario: Visitor making an appointment request
    When I make a request for a time slot
    Then I should see the request sent confirmation

  Scenario: Logged in user making an appointment request
    When I make a request for a time slot while logged in
    Then I should see the request sent confirmation

  Scenario: Logged out user making an appointment request
    When I make a request for a time slot while logged out
    Then I should see the request sent confirmation

