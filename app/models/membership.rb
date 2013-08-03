class Membership < ActiveRecord::Base

  attr_accessible :tenant, :user

  belongs_to :user
  belongs_to :tenant

  class << self
    def make user, tenant
      create user: user, tenant: tenant
    end
  end
end
