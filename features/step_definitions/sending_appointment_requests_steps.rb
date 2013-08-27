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
  first('.calendar-page-time-slot a').click
  page.should have_content 'Need an account?'
  within('#signup-request-form') do
    fill_in 'request_form[name]', with: "New User"
    fill_in 'request_form[email]', with: "user@example.com"
    fill_in 'request_form[password]', with: "password"
    fill_in 'request_form[password_confirmation]', with: "password"
  end
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
  first('.calendar-page-time-slot a').click
  page.should have_content 'Confirm your password to request an appointment'
  fill_in 'request_form[password]', with: password
  click_button "Send request"
end

When(/^I make a request for a time slot while logged out$/) do
  email = "example@example.com"
  password = 'password'
  Fabricate :user, email: email, password: password,
    password_confirmation: password
  visit root_url subdomain: 'fiddlehead-fern'
  first('.calendar-page-time-slot a').click
  page.should have_content 'Have an account?'
  within('#login-request-form') do
    fill_in 'request_form[email]', with: email
    fill_in 'request_form[password]', with: password
    click_button "Log in and request"
  end
end

Then(/^I should see the request sent confirmation$/) do
  page.should have_content "Thank you! Your appointment request has been sent"
end
