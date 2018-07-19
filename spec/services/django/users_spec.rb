require 'rails_helper'

describe Django::Users do
  it 'initializes with base attributes' do
    service = Django::Users.new()

    expect(service.base_url).to eq('https://4f29d79d-6b37-48ca-a3af-a77a02a03b3b.mock.pstmn.io')
  end
end
