class DeleteAllUserPointsJob < ApplicationJob
  queue_as :default

  def perform(scavenger_hunt_id)
    service = ElasticService.new(scavenger_hunt_id)
    service.delete_all_user_points.deliver_now
  end
end
