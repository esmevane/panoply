module TimeSlotHelper

  def time_slots providers, date, &block
    TimeSlotPresenter.new self, providers, date, block
  end

  def time_slot_tag providers, date, &block
    time_slots(providers, date, &block).list
  end

end