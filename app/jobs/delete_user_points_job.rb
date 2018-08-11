class DeleteUserPointsJob < ApplicationJob
  queue_as :default

  def perform(scavenger_hunt_id, user_id)
    service = ElasticService.new(scavenger_hunt_id)
    service.delete_user_points(user_id)
  end
end
