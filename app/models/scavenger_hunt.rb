class ScavengerHunt
  include ActiveModel::Model

  attr_accessor :name, :description, :id, :username, :user_id, :created_at
  validates_presence_of :name, :description
end
