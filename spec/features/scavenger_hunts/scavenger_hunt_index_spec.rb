require 'rails_helper'

feature 'A logged in user' do
  context 'on the scavenger hunts index' do
    scenario 'can see a list of all scavenger hunts' do
      visit root_path

      click_on 'Log In'

      expect(current_path).to eq(login_path)

      fill_in 'username', with: 'test'
      fill_in 'password', with: 'password'

      click_on 'Log In'

      visit '/scavenger_hunts'

      expect(page).to have_content 'Scavenger Hunts'
    end
  end
end
