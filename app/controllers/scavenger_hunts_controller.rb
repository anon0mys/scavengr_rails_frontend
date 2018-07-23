class ScavengerHuntsController < ApplicationController
  def index
    user = User.new(session[:current_user]) if session[:current_user]
    service = Django::ScavengerHunts.new(user)
    @scavenger_hunts = service.find_all
  end

  def new
    @scavenger_hunt = ScavengerHunt.new()
  end

  def create
    user = User.new(session[:current_user])
    scavenger_hunt = ScavengerHunt.new(hunt_params)
    service = Django::ScavengerHunts.new(user)
    response = service.create(scavenger_hunt)
    flash[:success] = "Scavenger hunt #{scavenger_hunt.name} created successfully"
    redirect_to scavenger_hunts_path
  end

  def show
    user = User.new(session[:current_user])
    service = Django::ScavengerHunts.new(user)
    @scavenger_hunt = service.find(params[:id])
  end

  private

  def hunt_params
    params.require(:scavenger_hunt).permit(:name, :description)
  end
end
