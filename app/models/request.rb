class Request < ActiveRecord::Base

  attr_accessible :availability, :availability_id, :sender

  belongs_to :sender, class_name: 'User'
  belongs_to :availability

end
