class ScavengerHuntChannel < ApplicationCable::Channel
  # called when user first subscribes
  # we can define where their information is "broadcast" from
  def subscribed
    stream_from "scavenger_hunt_#{params[:room]}"
  end

  # called when a Consumer sends information to the server
  def receive(data)
    # find scavenger_hunt using owner_uuid
    # trip = Trip.find_by!(owner_uuid: data['owner_uuid'])

    # add additional checkin
    # not recording in demo to keep DB small on free Heroku
    # checkin = scavenger_hunt.checkins.create!({
    #   lat: data['lat'],
    #   lon: data['lon'],
    #   captured_at: Time.zone.at(data['captured_at'] / 1000)
    # })

    # broadcast checkin to subscribers
    ActionCable.server.broadcast("scavenger_hunt_#{params[:room]}", {
      lat: data['lat'],
      lon: data['lon'],
      captured_at: data['captured_at']
    })
  end
end
