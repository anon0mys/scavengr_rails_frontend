class DeleteSingleUserPointJob < ApplicationJob
  queue_as :default

  def perform(point_id, scavenger_hunt_id)
    service = ElasticService.new(scavenger_hunt_id)
    service.delete_user_point(point_id)
  end
end
