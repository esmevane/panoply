class SignupRequestForm < RequestForm
  delegate :valid?, :errors, to: :user

  def post_initialize options
    visitor_params  = { params: options[:params], session: options[:session] }
    visitor_service = CreateVisitorService.new visitor_params
    @user           = visitor_service.perform
  end

  def persist!
    user.save
    Request.create sender: user, availability_id: slot_id
  end

end