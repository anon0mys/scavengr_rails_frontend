class ApplicationController < ActionController::Base
  helper_method :current_user, :authenticate!

  def current_user
    @user ||= User.new(session[:current_user]) if session[:current_user]
  end

  def authenticate!
    if current_user.nil?
      redirect_to root_path
    end
  end

  def not_found
    render 'layouts/not_found'
  end
end
