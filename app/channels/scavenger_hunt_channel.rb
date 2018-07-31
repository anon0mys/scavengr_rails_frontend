class ScavengerHuntChannel < ApplicationCable::Channel
  # called when user first subscribes
  # we can define where their information is "broadcast" from
  def subscribed
    find_or_create_user_points
    stream_from "scavenger_hunt_#{params[:scavengerHuntId]}_user_#{params[:userId]}"
  end

  # called when a Consumer sends information to the server
  def receive(data)
    # broadcast checkin to subscribers
    location = {lat: data['lat'], lon: data['lon']}

    ActionCable.server.broadcast("scavenger_hunt_#{params[:scavengerHuntId]}_user_#{params[:userId]}", {
      outside_range: client.outside_radius(location, params[:userId]),
      in_range: client.within_radius(location, params[:userId]),
      found: client.found_points(params[:userId]),
      lat: data['lat'],
      lon: data['lon'],
      captured_at: data['captured_at']
    })
  end

  private
    def find_or_create_user_points
      @user_points ||= client.find_or_create_user_points(params[:userId])
    end

    def client
      @client ||= ElasticService.new(params[:scavengerHuntId])
    end
end
