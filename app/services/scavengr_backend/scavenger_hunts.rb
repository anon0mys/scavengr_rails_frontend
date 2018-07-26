module ScavengrBackend
  class ScavengerHunts
    attr_reader :base_url, :user

    def initialize(user)
      @base_url = 'https://scavengr-django.herokuapp.com'
      @conn = Faraday.new(url: @base_url)
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

    private

    def get(path)
      @conn.get do |req|
        req.url path
        req.headers['Authorization'] = "Token #{user.token}"
      end
    end

    def post(path, payload)
      @conn.post do |req|
        req.url path
        req.headers['Content-Type'] = 'application/json'
        req.headers['Authorization'] = "Token #{user.token}"
        req.body = payload
      end
    end

    def put(path, payload)
      @conn.put do |req|
        req.url path
        req.headers['Content-Type'] = 'application/json'
        req.headers['Authorization'] = "Token #{user.token}"
        req.body = payload
      end
    end

    def delete(path)
      @conn.delete do |req|
        req.url path
        req.headers['Content-Type'] = 'application/json'
        req.headers['Authorization'] = "Token #{user.token}"
      end
    end
  end
end
