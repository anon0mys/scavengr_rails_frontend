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

    def add_current_scavenger_hunt(scavenger_hunt_id)
      response = post("/api/v1/current_scavenger_hunts/", { scavenger_hunt_id: scavenger_hunt_id })
      JSON.parse(response.body, symbolize_names: true)
    end

    def current_scavenger_hunts
      response = get("/api/v1/current_scavenger_hunts/")
      hunts = JSON.parse(response.body, symbolize_names: true)
      hunts.map do |hunt|
        ScavengerHunt.new(hunt)
      end
    end
  end
end
