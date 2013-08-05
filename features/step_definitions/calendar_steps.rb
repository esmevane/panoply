Given(/^I am on the home page$/) do
  visit root_path
end

Given(/^I have the tenant Fiddlehead Fern with members:$/) do |table|
  tenant = Fabricate :tenant, name: "Fiddlehead Fern"
  users = table.hashes.map { |hash| Fabricate :user, hash }
  users.each do |user|
    Membership.make user, tenant
  end
end

Given(/^they each have one (\d+)\-hour time slot today$/) do |hours|
  tenant    = Tenant.where(name: "Fiddlehead Fern").first
  starts_on = Date.today.beginning_of_day
  ends_on   = Date.today.beginning_of_day + hours.to_i.hours
  tenant.members.each do |member|
    Availability.slot_time_for starts_on: starts_on,
      ends_on: ends_on, provider: member
  end
end

Given(/^I have a tenant with available time$/) do
  tenant = Fabricate :tenant, name: "Fiddlehead Fern"
  user   = Fabricate :user, name: "Talina Woods"
  Membership.make user, tenant
  starts_on = Date.today.beginning_of_day
  ends_on   = Date.today.beginning_of_day + 6.hours
  Availability.slot_time_for starts_on: starts_on,
    ends_on: ends_on, provider: user
end

When(/^I make a request for a time slot$/) do
  visit root_url subdomain: 'fiddlehead-fern'
  click_link "Talina Woods"
  page.should have_content 'Sign up to request an appointment'
  fill_in 'request_form[name]', with: "New User"
  fill_in 'request_form[email]', with: "user@example.com"
  fill_in 'request_form[password]', with: "password"
  fill_in 'request_form[password_confirmation]', with: "password"
  click_button "Sign up and request"
end

When(/^I make a request for a time slot while logged in$/) do
  email = "example@example.com"
  password = 'password'
  Fabricate :user, email: email, password: password,
    password_confirmation: password
  visit "#{root_url(subdomain: 'fiddlehead-fern')}/users/sign_in"
  fill_in "user_email", with: email
  fill_in "user_password", with: password
  click_button "Sign in"
  visit root_url subdomain: 'fiddlehead-fern'
  click_link "Talina Woods"
  page.should have_content 'Confirm your password to request an appointment'
  fill_in 'request_form[password]', with: password
  click_button "Send request"
end

When(/^I click the make an appointment link$/) do
  click_link "Make an appointment"
end

When(/^I visit the Fiddlehead Fern calendar$/) do
  visit appointments_url(subdomain: "fiddlehead-fern")
end

Then(/^I should see the request sent confirmation$/) do
  page.should have_content "Thank you! Your appointment request has been sent"
end

Then(/^I should see the appointment calendar$/) do
  calendar_phrases = [ "Book an appointment", "Therapists",
    "Bio", "This month" ]

  calendar_phrases.each { |phrase| page.should have_content phrase }
end

Then(/^I should not see the appointment calendar$/) do
  calendar_phrases = [ "Book an appointment", "Therapists",
    "Bio", "This month" ]

  calendar_phrases.each { |phrase| page.should_not have_content phrase }
end

Then(/^I should see the names:$/) do |table|
  table.hashes.each { |hash| page.should have_content hash['name'] }
end

Then(/^I should see three time slots$/) do
  all('.time-slot').count.should == 3
end