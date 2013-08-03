class TimeSlotPresenter < Struct.new :view, :providers, :date, :callback

  delegate :content_tag, to: :view

  def list
    if providers.any? && slots.any?
      content_tag :ul, list_items, class: 'time-slots'
    end
  end

  def provider_for slot
    providers.find { |provider| provider.id == slot.provider_id }
  end

  def slots
    @slots ||= find_slots
  end

  private

  def list_items
    slots.map { |slot| build_list_item slot  }.join.html_safe
  end

  def build_list_item slot
    contents = view.capture slot, provider_for(slot), &callback
    content_tag :li, contents, class: 'time-slot'
  end

  def find_slots
    range = date.beginning_of_day..date.end_of_day
    Availability.where starts_on: range, provider_id: provider_ids
  end

  def provider_ids
    providers.map &:id
  end

end