class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation,
    :remember_me

  has_many :availabilities, foreign_key: :provider_id
  has_many :memberships
  has_many :tenancies, through: :memberships, source: :tenant
  has_many :subscriptions, foreign_key: :owner_id
  has_many :owned_tenancies, through: :subscriptions, source: :tenants

end
