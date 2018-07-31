class UserPoint
  include ActiveModel::Model

  attr_accessor :message, :location, :scavenger_hunt_id, :clue, :address, :user_id, :found, :id
end
