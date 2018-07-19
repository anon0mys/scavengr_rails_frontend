class User
  include ActiveModel::Model
  include ActiveModel::SecurePassword

  attr_accessor :email, :password_digest, :id, :auth_token
  validates_presence_of :email, :password_digest
  has_secure_password
end
