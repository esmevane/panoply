class SubscriptionsController < ApplicationController
  def create
    if subscription_form.submit
      redirect_to root_path, notice: "You have been subscribed!"
    else
      render :new
    end
  end

  protected

  def subscription_form
    @subscription_form ||= SubscriptionForm.new params: subscription_params,
      session: session, controller: self
  end
  helper_method :subscription_form

  def subscription_params
    params.fetch(:subscription_form) { Hash.new }
  end
end