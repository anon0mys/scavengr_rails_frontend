class DeleteCorrespondingUserPointsJob < ApplicationJob
  queue_as :default

  def perform(scavenger_hunt_id, point_id)
    service = ElasticService.new(scavenger_hunt_id)
    service.delete_user_point(point_id)
  end
end
