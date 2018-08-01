class PointsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate!

  def new
  end

  def create
    service = ScavengrBackend::ScavengerHunts.new(current_user)
    scavenger_hunt = service.find(params[:scavenger_hunt_id])
    if scavenger_hunt.user_id == current_user.id
      elastic = ElasticService.new(scavenger_hunt.id)
      elastic.add_point(point_params, 'points')
      render json: {message: 'Success'}, status: 201
    else
      render json: {message: 'Failure'}, status: 401
    end
  end

  private

  def point_params
    JSON.parse(request.body.to_json)[0]
  end
end
