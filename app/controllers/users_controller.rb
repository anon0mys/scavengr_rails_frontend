class UsersController < ApplicationController
  def new
  end

  def create
    user = User.new(user_params)
    service = Django::Users.new()
    response = service.create(user)
    session[:user_id] = response[:user][:id]
    session[:auth_token] = response[:user][:auth_token]
    flash[:success] = 'Your account was created successfully'
    redirect_to root_path
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
