module Django
  class UserScavengerHunts
    attr_reader :base_url, :user

    def initialize(current_user, username)
      @base_url = 'https://scavengr-django.herokuapp.com'
      @conn = Faraday.new(url: @base_url)
      @user = current_user
      @username = username
    end

    def find_all
      response = get("/api/v1/users/#{@username}/scavenger_hunts/")
      hunts = JSON.parse(response.body, symbolize_names: true)
      hunts.map do |hunt|
        ScavengerHunt.new(hunt)
      end
    end

    private

    def get(path)
      @conn.get do |req|
        req.url path
        req.headers['Authorization'] = "Token #{user.token}"
      end
    end
  end
end
