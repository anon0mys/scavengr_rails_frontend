require 'rails_helper'

describe ElasticService do
  context 'attributes' do
    it 'initializes with an elastic search client' do
      service = ElasticService.new()

      expect(service.client).to be_instance_of Elasticsearch::Client
    end
  end
end
