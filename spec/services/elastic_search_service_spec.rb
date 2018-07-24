require 'rails_helper'

describe ElasticService do
  context 'attributes' do
    it 'initializes with an elastic search client' do
      service = ElasticService.new(1)

      expect(service.client).to be_instance_of Elasticsearch::Transport::Client
    end
  end

  context 'queries' do
    it 'can find all points' do
      service = ElasticService.new(1)

      query_results = service.all_points

      expect(query_results.length).to eql 2
      expect(query_results.first).to be_a Point
      expect(query_results.first.message).to eql "Shouldn't find this one"
    end

    it 'can find points within set distance of a location' do
      service = ElasticService.new(1)

      location = {lat: 40, lon: -70}
      radius = '500km'

      query_results = service.within_radius(location, radius)

      expect(query_results.length).to eql 1
      expect(query_results.first).to be_a Point
      expect(query_results.first.message).to eql "Found the point"
    end

    it 'can find points outside set distance of a location' do
      service = ElasticService.new(1)

      location = {lat: 40, lon: -70}
      radius = '500km'

      query_results = service.outside_radius(location, radius)

      expect(query_results.length).to eql 1
      expect(query_results.first).to be_a Point
      expect(query_results.first.message).to eql "Shouldn't find this one"
    end
  end
end
