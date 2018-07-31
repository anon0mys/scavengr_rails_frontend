class UserPointsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def update
    if current_user.id == point_params[:user_id]
      client.update_point(point_params[:id], 'user_points')
      render json: {message: 'Success'}, status: 201
    end
  end

  private

  def point_params
    param = JSON.parse(request.body.to_json)[0]
    @point_params ||= JSON.parse(param, symbolize_names: true)
  end

  def client
    @client = ElasticService.new(point_params[:scavenger_hunt_id])
  end
end
