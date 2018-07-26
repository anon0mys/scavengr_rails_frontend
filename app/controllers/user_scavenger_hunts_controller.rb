class UserScavengerHuntsController < ApplicationController
  def index
    service = ScavengrBackend::UserScavengerHunts.new(current_user, params[:username])
    @username = params[:username]
    @scavenger_hunts = service.find_all
  end
end
