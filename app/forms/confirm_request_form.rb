class ConfirmRequestForm < RequestForm
  validates :password, :slot_id, presence: true
  validate :valid_password

  def persist!
    Request.create sender: user, availability_id: slot_id
  end

  private

  def valid_password
    errors.add(:password, "is invalid") unless user.valid_password? password
  end

end