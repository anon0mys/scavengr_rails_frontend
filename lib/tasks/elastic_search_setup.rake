namespace :elasticsearch do
  desc "TODO"
  task index_setup: :environment do
    begin
      client = Elasticsearch::Client.new
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
    rescue Elasticsearch::Transport::Transport::Errors::BadRequest => e
      message = JSON.parse(e.message[6..-1], symbolize_names: true)
      puts message[:error][:root_cause][0][:reason]
    end
  end
end
