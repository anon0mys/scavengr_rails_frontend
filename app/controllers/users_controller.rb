class UsersController < ApplicationController
  def new
  end

  def create
    user = User.new(user_params)
    service = ScavengrBackend::Users.new()
    response = service.create(user)
    if response[:token]
      session[:current_user] = response
      flash[:success] = "Welcome to Scavengr, #{response[:username]}!"
      redirect_to root_path
    else
      flash[:fail] = 'Failed to create account. Username and/or email already registered.'
      redirect_to create_account_path
    end
  end

  private

  def user_params
    params.permit(:email, :password, :username)
  end
end
