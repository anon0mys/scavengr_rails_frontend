module ScavengrBackend
  class ScavengerHunts < ScavengrBackend::BaseApiInteractions
    def initialize(user)
      super
      @user = user
    end

    def find_all()
      response = get('/api/v1/scavenger_hunts/')
      hunts = JSON.parse(response.body, symbolize_names: true)
      hunts.map do |hunt|
        ScavengerHunt.new(hunt)
      end
    end

    def find(id)
      response = get("/api/v1/scavenger_hunts/#{id}")
      binding.pry
      ScavengerHunt.new(JSON.parse(response.body, symbolize_names: true))
    end

    def create(scavenger_hunt)
      response = post('/api/v1/scavenger_hunts/', scavenger_hunt.to_json)
      JSON.parse(response.body, symbolize_names: true)
    end

    def update(scavenger_hunt)
      response = put("/api/v1/scavenger_hunts/#{scavenger_hunt.id}", scavenger_hunt.to_json)
      JSON.parse(response.body, symbolize_names: true)
    end

    def destroy(id)
      delete("/api/v1/scavenger_hunts/#{id}")
    end
  end
end
