class LoginRequestForm
  attr_accessor :slot_id, :email, :password
  attr_reader :user, :controller

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  delegate :errors, to: :user

  class << self
    def model_name
      ActiveModel::Name.new self, nil, "RequestForm"
    end
  end

  def initialize user, params, session, controller = nil
    @user = User.where(email: params[:email]).first
    @password = params[:password]
    @controller = controller
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

  def valid?
    user.valid_password? password
  end

  def valid_password
    errors.add(:password, "is invalid") unless user.valid_password? password
  end

  def persist!
    sign_in
    Request.create sender: user, availability_id: slot_id
  end

  def sign_in
    controller.sign_in :user, user
  end

end