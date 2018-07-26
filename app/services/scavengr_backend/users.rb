module ScavengrBackend
  class Users < ScavengrBackend::BaseApiInteractions
    def initialize()
      super
    end

    def create(user)
      response = post('/api/v1/users/', user_attributes(user))
      JSON.parse(response.body, symbolize_names: true)
    end

    def authenticate(user)
      response = post('/api/v1/users/authenticate/', user_attributes(user))
      JSON.parse(response.body, symbolize_names: true)
    end

    private

    def user_attributes(user)
      attrs = { username: user.username, email: user.email, password: user.password }
      attrs.to_json
    end
  end
end
