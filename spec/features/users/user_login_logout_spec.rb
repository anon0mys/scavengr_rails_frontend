require 'rails_helper'

feature 'A registered user' do
  context 'from the home page' do
    scenario 'can log in' do
      visit root_path

      click_on 'Log In'

      expect(current_path).to eq(login_path)

      fill_in 'username', with: 'test'
      fill_in 'password', with: 'password'

      click_on 'Log In'

      expect(current_path).to eq(root_path)
      expect(page).to have_content('Logged in as: test')
      expect(page).to have_content('Log Out')
      expect(page).to_not have_content('Log In')
    end
  end
end
