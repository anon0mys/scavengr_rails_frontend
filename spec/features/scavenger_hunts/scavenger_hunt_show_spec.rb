require 'rails_helper'

feature 'A logged in user' do
  scenario 'can see the scavenger hunt information' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    scavenger_hunt = ScavengerHunt.new(name: 'Test Scavenger Hunt', description: 'Testing the ability to add hunts')
    service = ScavengrBackend::ScavengerHunts.new(@user)
    service.create(scavenger_hunt)

    visit scavenger_hunt_path(1)

    expect(page).to have_content 'Test Scavenger Hunt'
    expect(page).to have_content 'Testing the ability to add hunts'
    expect(page).to have_content 'test'
  end
end
