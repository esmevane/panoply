class SignupRequestForm
  attr_accessor :slot_id, :name, :email, :password, :password_confirmation
  attr_reader :user

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  delegate :valid?, :errors, to: :user

  class << self
    def model_name
      ActiveModel::Name.new self, nil, "RequestForm"
    end
  end

  def initialize params, session
    @user = new_user_with_params params, session
  end

  def notice
    "Thank you!  Your appointment request has been sent"
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

  def new_user_with_params params, session
    user_params = params.symbolize_keys.except(:slot_id)
    User.new_with_session user_params, session
  end

  def persist!
    user.save
    Request.create sender: user, availability_id: slot_id
  end

end