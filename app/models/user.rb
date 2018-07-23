class User
  include ActiveModel::Model

  attr_accessor :email, :password, :id, :token, :username
  validates_presence_of :email, :password, :username
end
