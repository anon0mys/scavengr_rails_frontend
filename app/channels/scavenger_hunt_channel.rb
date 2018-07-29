class ScavengerHuntChannel < ApplicationCable::Channel
  # called when user first subscribes
  # we can define where their information is "broadcast" from
  def subscribed
    # find all user_hunt_points
    create_user_points if user_points.empty?
    binding.pry
    # if there are none find all points from scavenger hunt
    # create user_hunt_points (user_id, scavenger_hunt_id, found(bool), location, message, clue, address)
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

  def user_points(user_id)
    client.all_user_points(user_id)
  end

  def create_user_points(u)
  end

  def client
    @client ||= ElasticService.new(scavenger_hunt_id)
  end
end
