require 'rails_helper'

feature 'A logged in user' do
  context 'from the new scavenger hunts path' do
    scenario 'can create a new scavenger hunt' do
      visit login_path
      fill_in 'username', with: 'test'
      fill_in 'password', with: 'password'

      click_on 'Log In'

      visit new_scavenger_hunt_path

      fill_in 'scavenger_hunt[name]', with: 'Test Scavenger Hunt'
      fill_in 'scavenger_hunt[description]', with: 'Testing the ability to add hunts'

      click_on 'Create Scavenger Hunt'

      expect(current_path).to eq(scavenger_hunts_path)
      expect(page).to have_content('Test Scavenger Hunt')
    end
  end
end
