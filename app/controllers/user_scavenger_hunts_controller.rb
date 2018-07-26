class UserScavengerHuntsController < ApplicationController
  def index
    service = ScavengrBackend::UserScavengerHunts.new(current_user, params[:username])
    @username = params[:username]
    @scavenger_hunts = service.find_all
  end

  def show
    redirect_to scavenger_hunt_path(params[:id]) unless current_user.username == params[:username]
    scavenger_service = ScavengrBackend::ScavengerHunts.new(current_user)
    @scavenger_hunt = scavenger_service.find(params[:id])
    es_service = ElasticService.new(@scavenger_hunt.id)
    @points = es_service.all_points
  end
end
