require 'rails_helper'

feature 'A logged in user' do
  scenario 'can see the scavenger hunt information' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit scavenger_hunt_path(2)

    expect(page).to have_content 'Test Scavenger Hunt'
    expect(page).to have_content 'Testing the ability to add hunts'
    expect(page).to have_content 'test'
  end
end
