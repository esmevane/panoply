module CalendarHelper

  def this_month
    Date.today.strftime("%B, %Y")
  end

  def calendar &block
    CalendarPresenter.new self, Date.today, block
  end

  def calendar_tag &block
    calendar(&block).week_lists
  end

end