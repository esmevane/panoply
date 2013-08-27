When(/^I visit the home page$/) do
  visit root_path
end

Then(/^I should see the login \/ sign up prompt$/) do
  page.should have_content "Login"
  page.should have_content "Sign up today for a free account"
end

Then(/^I should not see the login \/ sign up prompt$/) do
  page.should_not have_content "Login"
  page.should_not have_content "Sign up today for a free account"
end