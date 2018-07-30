namespace :elasticsearch do
  desc "TODO"
  task index_setup: :environment do
    def client
      @client ||= Elasticsearch::Client.new
    end

    begin
      client.indices.create index: 'points',
                            body: {
                              mappings: {
                                _doc: {
                                  properties: {
                                    point: {
                                      properties: {
                                        location: {
                                            type: "geo_point"
                                        }
                                      }
                                    }
                                  }
                                }
                              }
                            }
      puts "Points index created"
    rescue Elasticsearch::Transport::Transport::Errors::BadRequest => e
      message = JSON.parse(e.message[6..-1], symbolize_names: true)
      puts message[:error][:root_cause][0][:reason]
    end

    begin
      client.indices.create index: 'user_points',
                            body: {
                              mappings: {
                                _doc: {
                                  properties: {
                                    user_point: {
                                      properties: {
                                        location: {
                                            type: "geo_point"
                                        }
                                      }
                                    }
                                  }
                                }
                              }
                            }
      puts "User Points index created"
    rescue Elasticsearch::Transport::Transport::Errors::BadRequest => e
      message = JSON.parse(e.message[6..-1], symbolize_names: true)
      puts message[:error][:root_cause][0][:reason]
    end
  end
end
