class CalendarPresenter < Struct.new :view, :date, :callback

  delegate :content_tag, to: :view

  def day_classes day
    classes = Array 'calendar-day'
    classes << 'calendar-today' if day == Date.today
    classes << 'calendar-inactive' if day.month != date.month
    classes.join(" ")
  end

  def month
    date.beginning_of_month..date.end_of_month
  end

  def week_lists
    weeks.map do |week|
      content_tag :li, week_list(week), class: 'calendar-week'
    end.join.html_safe
  end

  def weeks
    week_starts.map do |day|
      day.beginning_of_week(:sunday)..day.end_of_week(:sunday)
    end
  end

  private

  def week_list week
    content_tag :ul, class: 'calendar-weekdays' do
      week.map { |day| day_item(day) }.join.html_safe
    end
  end

  def day_item day
    content_tag :li, view.capture(day, &callback), class: day_classes(day)
  end

  def week_starts
    month.map(&:beginning_of_week).uniq
  end

end