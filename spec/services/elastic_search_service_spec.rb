require 'rails_helper'

describe ElasticService do
  context 'attributes' do
    it 'initializes with an elastic search client' do
      scavenger_hunt_id = 1
      service = ElasticService.new(scavenger_hunt_id)

      expect(service.client).to be_instance_of Elasticsearch::Transport::Client
    end
  end

  context 'points' do
    it 'can add a point to the index' do
      scavenger_hunt_id = 2
      service = ElasticService.new(scavenger_hunt_id)

      point_attrs = { point: {
                        message: "Test adding point",
                        clue: 'test clue',
                        address: '123 test address',
                    		scavenger_hunt_id: 2,
                    		location: [40.12, -70.34]
                      }
                    }

      service.add_point(point_attrs, 'points')

      query_results = service.all_points

      expect(query_results.last).to be_a Point
      expect(query_results.last.message).to eql "Test adding point"
    end
  end

  context 'user_points' do
    it 'can add a user point to the index' do
      scavenger_hunt_id = 2
      user_id = 1
      service = ElasticService.new(scavenger_hunt_id)

      point_attrs = { user_point: {
                        message: "Test adding user point",
                        clue: 'test clue',
                        address: '123 test address',
                    		scavenger_hunt_id: scavenger_hunt_id,
                        user_id: user_id,
                        found: false,
                    		location: [40.12, -70.34]
                      }
                    }

      service.add_point(point_attrs, 'user_points')

      query_results = service.all_user_points(user_id)

      expect(query_results.first).to be_a UserPoint
      expect(query_results.first.message).to eql "Test adding user point"
    end
  end

  context 'queries' do
    it 'can find all points' do
      scavenger_hunt_id = 1
      service = ElasticService.new(scavenger_hunt_id)

      query_results = service.all_points

      expect(query_results.length).to eql 2
      expect(query_results.first).to be_a Point
      expect(query_results.first.message).to eql "Shouldn't find this one"
    end

    it 'can find points within set distance of a location' do
      scavenger_hunt_id = 1
      service = ElasticService.new(scavenger_hunt_id)

      location = {lat: 40, lon: -70}
      radius = '500km'

      query_results = service.within_radius(location, radius)

      expect(query_results.length).to eql 1
      expect(query_results.first).to be_a Point
      expect(query_results.first.message).to eql "Found the point"
    end

    it 'can find points outside set distance of a location' do
      scavenger_hunt_id = 1
      service = ElasticService.new(scavenger_hunt_id)

      location = {lat: 40, lon: -70}
      radius = '500km'

      query_results = service.outside_radius(location, radius)

      expect(query_results.length).to eql 1
      expect(query_results.first).to be_a Point
      expect(query_results.first.message).to eql "Shouldn't find this one"
    end
  end
end
