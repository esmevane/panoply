module TimeSlotHelper

  def time_slots_for_today member
    range = Date.today.beginning_of_day..Date.today.end_of_day
    Availability.where starts_on: range, provider_id: member.id
  end

  def time_slots providers, date, &block
    TimeSlotPresenter.new self, providers, date, block
  end

  def time_slot_tag providers, date, &block
    time_slots(providers, date, &block).list
  end

end