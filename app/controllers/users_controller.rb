class UsersController < ApplicationController
  def new
  end

  def create
    user = User.new(user_params)
    service = ScavengrBackend::Users.new()
    response = service.create(user)
    session[:current_user] = response
    flash[:success] = 'Your account was created successfully'
    redirect_to root_path
  end

  private

  def user_params
    params.permit(:email, :password, :username)
  end
end
