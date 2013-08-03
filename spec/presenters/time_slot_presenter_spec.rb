require 'spec_helper'

describe TimeSlotPresenter do

  let(:view)  { ActionView::Base.new }
  let(:users) { [ Fabricate(:user), Fabricate(:user) ] }

  let(:today) { Date.today }
  let(:yesterday) { today - 1.day }

  let(:time_slot_today) do
    Fabricate :availability, starts_on: today.beginning_of_day,
      ends_on: today.beginning_of_day + 6.hours,
      provider: users.first
  end

  let(:time_slot_yesterday) do
    Fabricate :availability, starts_on: yesterday.beginning_of_day,
      ends_on: yesterday.beginning_of_day + 6.hours,
      provider: users.first
  end

  let(:presenter) { TimeSlotPresenter.new(view, users, today) }

  describe '#slots' do
    subject { presenter.slots }
    it { should include time_slot_today }
    it { should_not include time_slot_yesterday }
  end

  describe '#provider_for' do
    subject { presenter.provider_for(time_slot_today) }
    it { should == users.first }
  end

end