# Availability has:
#  - one provider (User instance)
#  - many appointment requests (AppointmentRequest collection)
#     * User can approve or deny requests
#  - a start time (Datetime)
#  - an end time (Datetime)
#
class Availability < ActiveRecord::Base

  attr_accessible :ends_on, :provider, :starts_on

  belongs_to :provider, class_name: 'User'

  class << self
    def slot_time_for attributes
      create attributes
    end
  end

end
