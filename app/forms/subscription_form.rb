class SubscriptionForm
  attr_accessor :email, :name, :organization_name, :password,
    :password_confirmation, :stripe_token

  attr_reader :controller, :stripe_token, :tenant_name, :user

  delegate :valid?, :errors, to: :user

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  def initialize options = Hash.new
    options = default_options.merge options
    @user = create_visitor options
    @controller = options[:controller]
    @tenant_name = options[:params].fetch(:organization_name) { nil }
    @stripe_token = options[:params].fetch(:stripe_token) { nil }
  end

  def persisted?
    false
  end

  def submit
    if valid?
      persist!
      true
    else
      false
    end
  end

  private

  def create_visitor options
    CreateVisitorService.new(options).perform
  end

  def subscribe_customer
    CustomerSubscriptionService.new(subscription_params).perform
  end

  def subscription_params
    { card_token: stripe_token, owner: user, tenant_name: tenant_name,
      controller: controller }
  end

  def persist!
    subscribe_customer if user.save
  end

  def default_options
    { params: Hash.new, session: Hash.new }
  end

end
