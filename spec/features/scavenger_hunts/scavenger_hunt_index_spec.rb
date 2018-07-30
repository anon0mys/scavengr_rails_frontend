require 'rails_helper'

feature 'A logged in user' do
  scenario 'can see a list of all scavenger hunts' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit '/scavenger_hunts'

    expect(page).to have_content 'Scavenger Hunts'
    expect(page).to have_content 'Test Scavenger Hunt'
  end
end
