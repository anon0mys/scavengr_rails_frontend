class ScavengerHuntsController < ApplicationController
  def index
    service = Django::ScavengerHunts.new(current_user)
    @scavenger_hunts = service.find_all
  end

  def new
    @scavenger_hunt = ScavengerHunt.new()
  end

  def create
    scavenger_hunt = ScavengerHunt.new(hunt_params)
    service = Django::ScavengerHunts.new(current_user)
    response = service.create(scavenger_hunt)
    flash[:success] = "Scavenger hunt #{scavenger_hunt.name} created successfully"
    redirect_to scavenger_hunts_path
  end

  def show
    service = Django::ScavengerHunts.new(current_user)
    @scavenger_hunt = service.find(params[:id])
  end

  private

  def hunt_params
    params.require(:scavenger_hunt).permit(:name, :description)
  end
end
