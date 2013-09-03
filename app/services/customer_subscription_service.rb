class CustomerSubscriptionService
  attr_reader :card_token, :controller, :owner, :tenant_name

  delegate :sign_in, to: :controller

  def initialize options = Hash.new
    @card_token = options.fetch(:card_token) { nil }
    @controller = options.fetch(:controller) { nil }
    @owner = options.fetch(:owner) { nil }
    @tenant_name = options.fetch(:tenant_name) { nil }
  end

  def perform
    sign_in :user, owner
    customer = new_stripe_customer
    subscription = local_subscription_record_for customer
    tenant = establish_tenancy_for subscription
    membership_for_owner_in tenant
  end

  private

  def new_stripe_customer
    message = "Customer record for #{owner.email}"
    Stripe::Customer.create email: owner.email, description: message,
      plan: 'default', card: card_token
  end

  def local_subscription_record_for stripe_customer
    Subscription.create owner: owner, stripe_token: stripe_customer.id
  end

  def establish_tenancy_for subscription
    Tenant.create subscription: subscription, name: tenant_name
  end

  def membership_for_owner_in tenant
    Membership.make owner, tenant
  end

end
