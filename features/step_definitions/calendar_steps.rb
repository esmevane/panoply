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

When(/^I visit the Fiddlehead Fern calendar$/) do
  visit appointments_url(subdomain: "fiddlehead-fern")
end

Then(/^I should see the appointment calendar$/) do
  calendar_phrases = [ "Book an appointment", Date.today.strftime("%e") ]
  calendar_phrases.each { |phrase| page.should have_content phrase }
end

Then(/^I should not see the appointment calendar$/) do
  calendar_phrases = [ "Book an appointment", Date.today.strftime("%e") ]
  calendar_phrases.each { |phrase| page.should_not have_content phrase }
end

Then(/^I should see the names:$/) do |table|
  table.hashes.each { |hash| page.should have_content hash['name'] }
end

Then(/^I should see three time slots$/) do
  all('.calendar-page-time-slot').count.should == 3
end