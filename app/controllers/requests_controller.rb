class RequestsController < ApplicationController

  def create
    if request_form.submit
      redirect_to root_path, notice: request_form.notice
    else
      render :new
    end
  end

  protected

  def request_form
    @request_form ||= request_form_class.new user: current_user,
      params: request_params, session: session, controller: self
  end
  helper_method :request_form

  def request_params
    request_form_params = params.fetch(:request_form) { Hash.new }
    slot_params = { 'slot_id' => params[:slot] }
    slot_params.merge(request_form_params).symbolize_keys
  end

  def request_form_class
    form_target = params.fetch(:form_target) { 'confirm' }
    [form_target, "request_form"].join("_").camelize.constantize
  end

end
