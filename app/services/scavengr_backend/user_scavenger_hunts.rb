module ScavengrBackend
  class UserScavengerHunts < ScavengrBackend::BaseApiInteractions
    def initialize(user, username)
      super
      @user = user
      @username = username
    end

    def find_all
      response = get("/api/v1/users/#{@username}/scavenger_hunts/")
      hunts = JSON.parse(response.body, symbolize_names: true)
      hunts.map do |hunt|
        ScavengerHunt.new(hunt)
      end
    end
  end
end
