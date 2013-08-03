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
  tenant             = Tenant.where(name: "Fiddlehead Fern").first
  availability_start = Date.today.beginning_of_day
  availability_end   = Date.today.beginning_of_day + hours.to_i
  tenant.members.each do |member|
    Availability.slot_time_for starts_on: availability_start,
      ends_on: availability_end, provider: member
  end
end

When(/^I click the make an appointment link$/) do
  click_link "Make an appointment"
end

When(/^I visit the Fiddlehead Fern calendar$/) do
  visit appointments_url(subdomain: "fiddlehead-fern")
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