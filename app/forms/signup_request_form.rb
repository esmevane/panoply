class SignupRequestForm < RequestForm
  delegate :valid?, :errors, to: :user

  def post_initialize options
    @user = new_user_with_params options[:params], options[:session]
  end

  def persist!
    user.save
    Request.create sender: user, availability_id: slot_id
  end

  private

  def new_user_with_params params, session
    user_params = params.symbolize_keys.except(:slot_id)
    User.new_with_session user_params, session
  end

end