require 'rails_helper'

describe ScavengrBackend::Users do
  it 'initializes with base attributes' do
    service = ScavengrBackend::Users.new()

    expect(service.base_url).to eq('https://scavengr-django.herokuapp.com')
  end

  context 'endpoints' do
    it 'POST to django /api/v1/users/' do
      user_attrs = { username: 'test', email: 'test@mail.com', password: 'password' }
      user = User.new(user_attrs)
      service = ScavengrBackend::Users.new()

      expected = { id: 1, username: 'test', email: 'test@mail.com', token: 'token' }

      stub_request(:post, 'https://scavengr-django.herokuapp.com/api/v1/users/')
      .to_return(status: 201, body: expected.to_json)

      response = service.create(user)

      expect(response[:email]).to eq(user.email)
      expect(response[:username]).to eq(user.username)
    end

    it 'POST to django /api/v1/users/authenticate/' do
      user_attrs = { username: 'test', password: 'password' }
      user = User.new(user_attrs)
      service = ScavengrBackend::Users.new()

      expected = { id: 1, username: 'test', email: 'test@mail.com', token: 'token' }

      # stub_request(:post, 'https://scavengr-django.herokuapp.com/api/v1/users/')
      # .to_return(status: 201, body: expected.to_json)

      response = service.authenticate(user)

      expect(response[:email]).to_not be nil
      expect(response[:username]).to eq(user.username)
    end
  end
end
