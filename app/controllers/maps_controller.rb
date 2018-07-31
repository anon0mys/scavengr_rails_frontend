
class MapsController < ApplicationController
  def show
    scavenger_service = ScavengrBackend::ScavengerHunts.new(current_user)
    scavenger_hunt = scavenger_service.find(scavenger_hunt_params["id"])
    add_to_current_hunts(scavenger_hunt)
    scavenger_hunt.user_id = current_user.id
    scavenger_hunt.username = current_user.username
    render json: scavenger_hunt.to_json
  end

  private
    def scavenger_hunt_params
      params.permit(:id)
    end

    def add_to_current_hunts(scavenger_hunt)
      client = ScavengrBackend::UserScavengerHunts.new(current_user, current_user.username)
      client.add_current_scavenger_hunt(scavenger_hunt.id)
    end
end
