class CurrentScavengerHuntsController < ApplicationController
  def index
    service = ScavengrBackend::UserScavengerHunts.new(current_user, current_user.username)
    @scavenger_hunts = service.current_scavenger_hunts
  end
end
