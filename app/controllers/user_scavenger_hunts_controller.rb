class UserScavengerHuntsController < ApplicationController
  def index
    service = Django::UserScavengerHunts.new(current_user, params[:username])
    @user = service.user
    @scavenger_hunts = service.find_all
  end
end
