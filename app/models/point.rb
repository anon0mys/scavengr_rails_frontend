class Point
  include ActiveModel::Model

  attr_accessor :message, :location, :scavenger_hunt_id, :clue, :address, :user_id, :found, :id, :point_id
  validates_length_of :message, minimum: 1, presence: true, allow_blank: false
  validates_length_of :clue, minimum: 1, presence: true, allow_blank: false
  validates_length_of :address, minimum: 1, presence: true, allow_blank: false
  validates_length_of :location, minimum: 1, presence: true, allow_blank: false
end
