class Tenant < ActiveRecord::Base

  attr_accessible :name, :domain

  has_many :memberships
  has_many :members, through: :memberships, source: :user

  before_create :assign_domain

  private

  def assign_domain
    self[:domain] = name.parameterize
  end

end
