class ScavengerHuntChannel < ApplicationCable::Channel
  # called when user first subscribes
  # we can define where their information is "broadcast" from
  def subscribed
    create_user_points if user_points.empty?
    stream_from "scavenger_hunt_#{params[:scavengerHuntId]}_user_#{params[:userId]}"
  end

  # called when a Consumer sends information to the server
  def receive(data)
    # broadcast checkin to subscribers
    ActionCable.server.broadcast("scavenger_hunt_#{params[:scavengerHuntId]}_user_#{params[:userId]}", {
      outside_range: [],  # Go get points outside radius
      in_range: [], # Go get points inside radius
      lat: data['lat'],
      lon: data['lon'],
      captured_at: data['captured_at']
    })
  end

  private

  def user_points
    client.all_user_points(params[:userId])
  end

  def create_user_points # Push this down to service layer
    scavenger_hunt_points.each do |point|
      point.user_id, point.found = params[:userId], false
      point_attrs = { user_point: point}
      client.add_point(point_attrs.to_json, 'user_points')
    end
  end

  def client
    @client ||= ElasticService.new(params[:scavengerHuntId])
  end

  def scavenger_hunt_points
    @scavenger_hunt_points ||= client.all_points
  end
end
