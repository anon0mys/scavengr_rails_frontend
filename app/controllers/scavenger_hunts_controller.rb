class ScavengerHuntsController < ApplicationController
  before_action :authenticate!

  def index
    service = ScavengrBackend::ScavengerHunts.new(current_user)
    @scavenger_hunts = service.find_all
  end

  def new
    @scavenger_hunt = ScavengerHunt.new()
  end

  def create
    scavenger_hunt = ScavengerHunt.new(hunt_params)
    service = ScavengrBackend::ScavengerHunts.new(current_user)
    response = service.create(scavenger_hunt)
    flash[:success] = "Scavenger hunt #{response[:name]} created successfully"
    redirect_to "/#{current_user.username}/scavenger_hunts/#{response[:id]}"
  end

  def show
    service = ScavengrBackend::ScavengerHunts.new(current_user)
    @scavenger_hunt = service.find(params[:id])
  end

  def edit
    service = ScavengrBackend::ScavengerHunts.new(current_user)
    @scavenger_hunt = service.find(params[:id])
  end

  def update
    scavenger_hunt = ScavengerHunt.new(hunt_params)
    scavenger_hunt.id = params[:id]
    service = ScavengrBackend::ScavengerHunts.new(current_user)
    response = service.update(scavenger_hunt)
    flash[:success] = "Scavenger hunt #{response[:name]} updated successfully"
    redirect_to "/#{current_user.username}/scavenger_hunts/#{response[:id]}"
  end

  def destroy
    DeletePointsJob.perform_later(params[:id])
    DeleteAllUserPointsJob.perform_later(params[:id])
  end

  private

  def hunt_params
    params.require(:scavenger_hunt).permit(:name, :description)
  end
end
