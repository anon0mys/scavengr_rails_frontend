class ElasticService
  attr_reader :client

  def initialize()
    @client = Elasticsearch::Client.new
  end
end
