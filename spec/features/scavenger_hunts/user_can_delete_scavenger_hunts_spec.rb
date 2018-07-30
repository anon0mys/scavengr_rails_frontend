require 'rails_helper'

feature 'A logged in user' do
  scenario 'can delete a scavenger hunt' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    service = ScavengrBackend::ScavengerHunts.new(@user)
    response = service.create({ name: 'Delete Me', description: 'Testing the ability to delete' })

    visit scavenger_hunts_path

    expect(page).to have_content 'Delete Me'

    visit scavenger_hunt_path(response[:id])

    click_on 'Delete'

    expect(current_path).to eq(scavenger_hunts_path)
    expect(page).to_not have_content 'Delete Me'
  end
end
