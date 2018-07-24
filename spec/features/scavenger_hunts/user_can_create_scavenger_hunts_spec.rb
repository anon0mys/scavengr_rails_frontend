require 'rails_helper'

feature 'A logged in user' do
  scenario 'can create a new scavenger hunt' do
    # stub_request(:post, 'https://scavengr-django.herokuapp.com/api/v1/scavenger_hunts')
    # .to_return(status: 201, body: File.read('./spec/fixtures/json/scavenger_hunt.json'))

    attrs = { id: 1, username: 'test', email: 'test@mail.com', token: '56963da5d3ab5155ae8f40fc3612f3a1986a5f38' }
    user = User.new(attrs)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit new_scavenger_hunt_path

    fill_in 'scavenger_hunt[name]', with: 'Test Scavenger Hunt'
    fill_in 'scavenger_hunt[description]', with: 'Testing the ability to add hunts'

    click_on 'Create Scavenger Hunt'

    expect(current_path).to eq(scavenger_hunts_path)
    expect(page).to have_content('Test Scavenger Hunt')
  end
end
