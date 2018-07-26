require 'rails_helper'

describe ScavengrBackend::ScavengerHunts do
  it 'initializes with base attributes' do
    user_attrs = { username: 'test', email: 'test@mail.com', password: 'password' }
    user = User.new(user_attrs)
    service = ScavengrBackend::ScavengerHunts.new(user)

    expect(service.base_url).to eql('https://scavengr-django.herokuapp.com')
    expect(service.user).to eql(user)
  end
end
