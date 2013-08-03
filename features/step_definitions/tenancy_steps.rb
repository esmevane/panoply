Given(/^the tenant Fiddlehead Fern$/) do
  Fabricate(:tenant, name: "Fiddlehead Fern")
end

When(/^I visit the Fiddlehead Fern home page$/) do
  visit root_url(subdomain: "fiddlehead-fern")
end

Then(/^I should see the Fiddlehead Fern calendar$/) do
  page.should have_content "Book an appointment"
end

Then(/^I should not see the Fiddlehead Fern calendar$/) do
  page.should_not have_content "Book an appointment"
end

Given(/^I have no tenants$/) do
  visit root_path
end

Then(/^I should see the standard application greeting$/) do
  page.should have_content "Sign up today"
end

Then(/^I should not see the Fiddlehead Fern path$/) do
  current_url.should_not include "fiddlehead-fern"
end