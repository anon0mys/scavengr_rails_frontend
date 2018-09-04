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
    service = ScavengrBackend::ScavengerHunts.new(current_user)
    response = service.destroy(params[:id])
    require 'pry'; binding.pry
    if response.status == 204
      DeletePointsJob.perform_later(params[:id])
      DeleteAllUserPointsJob.perform_later(params[:id])
      flash[:success] = "Scavenger hunt deleted"
    else
      flash[:error] = "Failed to delete scavenger hunt"
    end
    redirect_to "/#{current_user.username}/scavenger_hunts"
  end

  private

  def hunt_params
    params.require(:scavenger_hunt).permit(:name, :description)
  end
end
