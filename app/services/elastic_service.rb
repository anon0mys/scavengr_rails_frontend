class ElasticService
  attr_reader :client, :scavenger_hunt_id

  def initialize(scavenger_hunt_id)
    @scavenger_hunt_id = scavenger_hunt_id
    @client = Elasticsearch::Client.new
  end

  def add_point(point_attrs, index)
    @client.create index: index,
                   type: '_doc',
                   body: point_attrs
  end

  def update_point(point_id, index)
    @client.update index: index,
                   type: '_doc',
                   id: point_id,
                   body: { doc: { user_point: { found: true } }}
  end

  # ADD found points query and add must_not match point.found = true to within and outside queries

  def all_points
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

  def find_or_create_user_points(user_id)
    create_user_points(user_id) if all_user_points(user_id).empty?
    return all_user_points(user_id)
  end

  def all_user_points(user_id)
    query = @client.search index: 'user_points',
                           body: {
                             query: {
                               bool: {
                                 must: [
                                   { match: {'user_point.scavenger_hunt_id' => @scavenger_hunt_id}},
                                   { match: {'user_point.user_id' => user_id}}
                                 ]
                               }
                             }
                           }
    convert_to_user_points(query['hits']['hits'])
  end

  def found_points(user_id)
    query = @client.search index: 'user_points',
                           body: {
                             query: {
                               bool: {
                                 must: [
                                   { match: {'user_point.scavenger_hunt_id' => @scavenger_hunt_id}},
                                   { match: {'user_point.user_id' => user_id}},
                                   { match: {'user_point.found' => true}}
                                 ]
                               }
                             }
                           }
    convert_to_user_points(query['hits']['hits'])
  end

  def within_radius(location, user_id,  radius = "250ft")
    query = @client.search index: 'user_points',
                           body: {
                             query: {
                               bool: {
                                 must: [
                                   { match: {'user_point.scavenger_hunt_id' => @scavenger_hunt_id}},
                                   { match: {'user_point.user_id' => user_id}},
                                   { match: {'user_point.found' => false}}
                                 ],
                                 filter: {
                                   geo_distance: {
                                     distance: radius,
                                     'user_point.location' => location
                                   }
                                 }
                               }
                             }
                           }
    convert_to_user_points(query['hits']['hits'])
  end

  def outside_radius(location, user_id, radius = "250ft")
    query = @client.search index: 'user_points',
                           body: {
                             query: {
                               bool: {
                                 must: [
                                   { match: {'user_point.scavenger_hunt_id' => @scavenger_hunt_id}},
                                   { match: {'user_point.user_id' => user_id}},
                                   { match: {'user_point.found' => false}}
                                 ],
                                 must_not: {
                                   geo_distance: {
                                     distance: radius,
                                     'user_point.location' => location
                                   }
                                 }
                               }
                             }
                           }
    convert_to_user_points(query['hits']['hits'])
  end

  private

    def create_user_points(user_id)
      all_points.each do |point|
        point.user_id, point.found = user_id, false
        point_attrs = { user_point: point}
        add_point(point_attrs.to_json, 'user_points')
      end
    end

    def convert_to_points(results)
      results.map do |result|
        point = Point.new(result['_source']['point'])
        point.id = result['_id']
        point
      end
    end

    def convert_to_user_points(results)
      results.map do |result|
        point = UserPoint.new(result['_source']['user_point'])
        point.id = result['_id']
        point
      end
    end
end
