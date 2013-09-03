module StripeCredentials
  def api_key
    ENV['stripe_api_key']
  end
  module_function :api_key

  def public_key
    ENV['stripe_public_key']
  end
  module_function :public_key
end

Stripe.api_key = StripeCredentials.api_key
