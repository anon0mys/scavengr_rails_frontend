class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.new(user_params)
    service = ScavengrBackend::Users.new()
    response = service.authenticate(user)
    session[:current_user] = response
    flash[:success] = 'Successfully logged in'
    redirect_to root_path
  end

  def destroy
    session.clear
    flash[:success] = 'Successfully logged out'
    redirect_to root_path
  end

  private

  def user_params
    params.permit(:username, :password)
  end
end
