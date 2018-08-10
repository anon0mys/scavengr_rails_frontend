class DeleteUserPointsJob < ApplicationJob
  queue_as :default

  def perform(scavenger_hunt_id)
    service = ElasticService.new(scavenger_hunt_id)
    require 'pry'; binding.pry
    service.delete_user_points(current_user.id).deliver_now
  end
end
