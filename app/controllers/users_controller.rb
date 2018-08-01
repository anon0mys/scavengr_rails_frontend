class UsersController < ApplicationController
  def new
  end

  def create
    user = User.new(user_params)
    service = ScavengrBackend::Users.new()
    response = service.create(user)
    if response[:token]
      session[:current_user] = response
      flash[:success] = 'Your account was created successfully'
      redirect_to root_path
    else
      flash[:failure] = 'Failed to create account'
      redirect_to create_account_path
    end
  end

  private

  def user_params
    params.permit(:email, :password, :username)
  end
end
