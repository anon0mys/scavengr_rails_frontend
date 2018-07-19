require 'rails_helper'

describe Django::Users do
  it 'initializes with base attributes' do
    service = Django::Users.new()

    expect(service.base_url).to eq('https://scavengr-django.herokuapp.com')
  end

  context 'endpoints' do
    it 'POST to django /api/v1/users' do
      user_attrs = { email: 'test@mail.com', password: 'password' }
      user = User.new(user_attrs)
      service = Django::Users.new()
      expected = { user: {:id=>2, :email=>"test@mail.com", :auth_token=>"test" }}

      stub_request(:post, 'https://scavengr-django.herokuapp.com/api/v1/users/')
        .to_return(status: 201, body: expected.to_json)

      response = service.create(user)

      expect(response).to eq(expected)
    end
  end
end
