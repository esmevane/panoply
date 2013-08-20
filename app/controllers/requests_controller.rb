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
    @request_form ||= request_form_class.new *request_form_arguments
  end
  helper_method :request_form

  def request_form_arguments
    [current_user, request_form_params, session, self]
  end

  def request_form_params
    request_params = params.fetch(:request_form) { Hash.new }
    slot_params = { 'slot_id' => params[:slot] }
    slot_params.merge(request_params).symbolize_keys
  end

  def request_form_class
    form_target = params.fetch(:form_target) { 'confirm' }
    [form_target, "request_form"].join("_").camelize.constantize
  end

end
