class ElasticService
  attr_reader :client

  def initialize(scavenger_hunt_id)
    @scavenger_hunt_id = scavenger_hunt_id
    @client = Elasticsearch::Client.new
  end

  def add_point(point)
    binding.pry
    @client.create index: 'points',
                   type: '_doc',
                   body: point.to_json
  end

  def all_points()
    query = @client.search index: 'points',
                           body: {
                             query: {
                               bool: {
                                 must: {
                                   match: {
                                     'point.scavenger_hunt_id' => @scavenger_hunt_id
                                   }
                                 }
                               }
                             }
                           }
    convert_to_points(query['hits']['hits'])
  end

  def within_radius(location, radius)
    query = @client.search index: 'points',
                           body: {
                             query: {
                               bool: {
                                 must: {
                                   match: {
                                     'point.scavenger_hunt_id' => @scavenger_hunt_id
                                   }
                                 },
                                 filter: {
                                   geo_distance: {
                                     distance: radius,
                                     'point.location' => location
                                   }
                                 }
                               }
                             }
                           }
    convert_to_points(query['hits']['hits'])
  end

  def outside_radius(location, radius)
    query = @client.search index: 'points',
                           body: {
                             query: {
                               bool: {
                                 must: {
                                   match: {
                                     'point.scavenger_hunt_id' => @scavenger_hunt_id
                                   }
                                 },
                                 must_not: {
                                   geo_distance: {
                                     distance: radius,
                                     'point.location' => location
                                   }
                                 }
                               }
                             }
                           }
    convert_to_points(query['hits']['hits'])
  end

  private

  def convert_to_points(results)
    results.map do |result|
      Point.new(result['_source']['point'])
    end
  end
end
