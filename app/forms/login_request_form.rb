class LoginRequestForm < RequestForm
  validates :email, :password, presence: true
  validate :valid_password

  def post_initialize options
    @email = options[:params].fetch(:email) { nil }
    @user = User.where(email: email).first
  end

  def persist!
    sign_in
    Request.create sender: user, availability_id: slot_id
  end

  private

  def valid_password
    errors.add(:password, "is invalid") unless user.valid_password? password
  end

  def sign_in
    controller.sign_in :user, user
  end

end