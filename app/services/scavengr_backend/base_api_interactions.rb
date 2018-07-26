module ScavengrBackend
  class BaseApiInteractions
    attr_reader :base_url, :user

    def initialize(*attrs)
      @base_url = ENV['BASE_URL']
      @conn = Faraday.new(url: @base_url)
    end

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
        req.headers['Authorization'] = "Token #{user.token}" if user
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
