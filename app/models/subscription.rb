class Subscription < ActiveRecord::Base
  attr_accessible :stripe_token, :owner

  validates :stripe_token, presence: true

  belongs_to :owner, class_name: 'User'
  has_many :tenants
end
