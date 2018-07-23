require 'rails_helper'

feature 'A logged in user' do
  scenario 'can see the scavenger hunt information' do
    # stub_request(:get, 'https://scavengr-django.herokuapp.com/api/v1/scavenger_hunts/1')
    # .to_return(status: 200, body: File.read('./spec/fixtures/json/scavenger_hunt.json'))

    attrs = { id: 1, username: 'test', email: 'test@mail.com', token: '56963da5d3ab5155ae8f40fc3612f3a1986a5f38' }
    user = User.new(attrs)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit scavenger_hunt_path(2)

    expect(page).to have_content 'Test Scavenger Hunt'
    expect(page).to have_content 'Testing the ability to add hunts'
    expect(page).to have_content 'test'
  end
end
