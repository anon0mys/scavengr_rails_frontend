
class MapsController < ApplicationController
  def show
    service = Django::ScavengerHunts.new(current_user)
    scavenger_hunt = service.find(scavenger_hunt_params["id"])
    scavenger_hunt.user_id = current_user.id
    scavenger_hunt.username = current_user.username
    render json: scavenger_hunt.to_json
  end

  private
    def scavenger_hunt_params
      params.permit(:id)
    end
end
