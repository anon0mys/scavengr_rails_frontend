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
    flash[:success] = "Scavenger hunt #{response[:name]} created successfully"
    redirect_to scavenger_hunts_path
  end

  def show
    service = Django::ScavengerHunts.new(current_user)
    @scavenger_hunt = service.find(params[:id])
  end

  def edit
    service = Django::ScavengerHunts.new(current_user)
    @scavenger_hunt = service.find(params[:id])
  end

  def update
    scavenger_hunt = ScavengerHunt.new(hunt_params)
    scavenger_hunt.id = params[:id]
    service = Django::ScavengerHunts.new(current_user)
    response = service.update(scavenger_hunt)
    flash[:success] = "Scavenger hunt #{response[:name]} updated successfully"
    redirect_to scavenger_hunt_path(response[:id])
  end

  def destroy
    service = Django::ScavengerHunts.new(current_user)
    service.destroy(params[:id])
    flash[:success] = "Scavenger hunt deleted"
    redirect_to scavenger_hunts_path
  end

  private

  def hunt_params
    params.require(:scavenger_hunt).permit(:name, :description)
  end
end
