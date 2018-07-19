class User
  def initialize(attrs)
    @email = attrs[:email]
    @password = BCrypt::Password.create(attrs[:password])
    @id = nil
  end
end
