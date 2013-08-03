@Panoply ?=
  toggleCalendarMonthClass: -> $('.calendar').toggleClass 'as-month'
  toggleHokusaiClass: -> $('body').toggleClass 'hokusai'

$(document).ready ->
  $calendarMonthToggle = $ '.toggle-calendar-class a'
  $calendarMonthToggle.on 'click', Panoply.toggleCalendarMonthClass

