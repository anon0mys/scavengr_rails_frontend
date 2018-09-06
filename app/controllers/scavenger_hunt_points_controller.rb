class ScavengerHuntPointsController < ApplicationController
  def destroy
    DeletePointsJob.perform_later(params[:scavenger_hunt_id])
    DeleteAllUserPointsJob.perform_later(params[:scavenger_hunt_id])
  end
end
