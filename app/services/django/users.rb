module Django
  class Users
    attr_reader :base_url

    def initialize()
      @base_url = 'https://4f29d79d-6b37-48ca-a3af-a77a02a03b3b.mock.pstmn.io'
      @conn = Faraday.new(url: @base_url)
    end

    def create(user)
      @conn.post do |req|
        req.url '/api/v1/users'
        req.body = user_attributes(user)
      end
    end

    private

    def user_attributes(user)
      attrs = { user: { email: user.email, password: user.password_digest }}
      attrs.to_json
    end
  end
end
