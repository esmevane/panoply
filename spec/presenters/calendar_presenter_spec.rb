require 'spec_helper'

describe CalendarPresenter do

  let(:view)  { ActionView::Base.new }
  let(:today) { Date.today }
  let(:start) { today.beginning_of_month }
  let(:final) { today.end_of_month }
  let(:month) { start..final }

  let(:presenter) { CalendarPresenter.new(view, today) }

  describe '#week_lists' do
    # Use nokogiri to measure ul/li elements created
    # Use nokogiri to measure classes gathered
  end

  describe '#day_classes' do

    let(:given_day) { today }

    subject { presenter.day_classes(given_day) }

    it "contains 'calendar-day'" do
      expect(subject).to include 'calendar-day'
    end

    context 'when the given day is today' do
      let(:given_day) { today }
      it "contains 'calendar-today'" do
        expect(subject).to include 'calendar-today'
      end
    end

    context 'when the given day is out of month' do
      let(:given_day) { today + 3.months }
      it "contains 'calendar-inactive'" do
        expect(subject).to include 'calendar-inactive'
      end
    end

  end

  describe '#month' do
    subject { presenter.month }
    it "returns the days of the month" do
      expect(subject).to eq month
    end
  end

  describe '#weeks' do

    let(:weeks) do
      month.map(&:beginning_of_week).uniq.map do |date|
        date.beginning_of_week(:sunday)..date.end_of_week(:sunday)
      end
    end

    subject { presenter.weeks }

    it "returns the weeks of the given month" do
      expect(subject).to eq weeks
    end

  end
end