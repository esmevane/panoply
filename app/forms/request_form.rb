class RequestForm
  attr_accessor :password, :slot_id

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  validates :password, presence: true
  validates :slot_id, presence: true

  validate :valid_password

  def initialize user, params
    @user = user
    @password = params && params.fetch(:password) { nil }
    @slot_id = params && params.fetch(:slot_id) { nil }
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

  def valid_password
    errors.add(:password, "is invalid") unless @user.valid_password? password
  end

  def persist!
    Request.create sender: @user, availability_id: slot_id
  end

end