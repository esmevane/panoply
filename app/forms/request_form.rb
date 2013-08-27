class RequestForm
  attr_accessor :email, :name, :password, :password_confirmation, :slot_id
  attr_reader :controller, :user

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  class << self
    def model_name
      ActiveModel::Name.new self, nil, "RequestForm"
    end
  end

  def initialize options = Hash.new
    options     = default_options.merge(options)
    @user       = options[:user]
    @password   = options[:params].fetch(:password) { nil }
    @slot_id    = options[:params].fetch(:slot_id) { nil }
    @controller = options[:controller]
    post_initialize options
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

  def post_initialize options
  end

  def persist!
  end

  private

  def default_options
    { user: User.new, params: Hash.new, session: Hash.new, controller: nil }
  end

end