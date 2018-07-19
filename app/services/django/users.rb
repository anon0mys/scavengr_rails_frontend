module Django
  class Users
    attr_reader :base_url

    def initialize()
      @base_url = 'https://scavengr-django.herokuapp.com'
      @conn = Faraday.new(url: @base_url)
    end

    def create(user)
      response = post('/api/v1/users', user_attributes(user))
      JSON.parse(response.body, symbolize_names: true)
    end

    private

    def post(path, payload)
      @conn.post do |req|
        req.url path
        req.body = payload
      end
    end

    def user_attributes(user)
      attrs = { user: { email: user.email, password: user.password_digest }}
      attrs.to_json
    end
  end
end
