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
    @request_form ||= if user_signed_in?
      RequestForm.new current_user, request_form_params
    else
      SignupRequestForm.new request_form_params, session
    end
  end
  helper_method :request_form

  def request_form_params
    request_params = params.fetch(:request_form) { Hash.new }
    slot_params = { 'slot_id' => params[:slot] }
    slot_params.merge(request_params).symbolize_keys
  end

end
