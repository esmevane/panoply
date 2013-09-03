class CreateVisitorService
  attr_reader :params, :session

  def initialize options = Hash.new
    @params = options.fetch(:params) { Hash.new }
    @session = options.fetch(:session) { Hash.new }
  end

  def perform
    User.new_with_session user_params, session
  end

  def user_params
    params.slice :email, :name, :password, :password_confirmation
  end
end