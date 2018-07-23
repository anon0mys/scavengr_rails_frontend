require 'rails_helper'

feature 'A logged in user' do
  context 'on a scavenger show page' do
    scenario 'can see the scavenger hunt information' do
      visit login_path
      fill_in 'username', with: 'test'
      fill_in 'password', with: 'password'

      click_on 'Log In'

      visit scavenger_hunt_path(1)

      expect(page).to have_content 'Test Scavenger Hunt'
      expect(page).to have_content 'Testing the ability to add hunts'
      expect(page).to have_content 'test'
    end
  end
end
