class HomeController < ApplicationController
  def index
    @user = User.new(session[:current_user]) if session[:current_user]
  end
end
