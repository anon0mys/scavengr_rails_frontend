class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    @user ||= User.new(session[:current_user]) if session[:current_user]
  end
end
