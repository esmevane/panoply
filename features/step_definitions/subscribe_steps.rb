When(/^I visit the subscription page$/) do
  click_button "Subscribe today"
  page.should have_content /Get started/i
end

When(/^I fill in my credit information$/) do
  within('#subscription-form') do
    fill_in 'subscription_form[name]', with: "New User"
    fill_in 'subscription_form[email]', with: "user@example.com"
    fill_in 'subscription_form[password]', with: "password"
    fill_in 'subscription_form[password_confirmation]', with: "password"
    fill_in 'subscription_form[organization_name]', with: 'Fiddlehead Fern'
    fill_in 'card-number', with: '4242 4242 4242 4242'
    fill_in 'card-code', with: '123'
    select 'January', from: 'date_month'
    select '2016', from: 'date_year'
    click_button 'Subscribe'
  end
end

Then(/^I should see the new subscription welcome$/) do
  page.should have_content "You have been subscribed"
  page.should_not have_button "Subscribe today"
end