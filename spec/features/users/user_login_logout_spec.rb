require 'rails_helper'

feature 'A registered user' do
  context 'from the home page' do
    scenario 'can log in' do
      visit root_path

      fill_in 'username', with: 'test'
      fill_in 'password', with: 'password'

      click_on 'Sign in'

      expect(current_path).to eq(root_path)

      within("nav") do
        expect(page).to have_content('test')
      end

      within("footer") do
        expect(page).to have_xpath(".//a[i[contains(@class, 'fas fa-sign-out-alt')]]")
        expect(page).to have_xpath(".//a[i[contains(@class, 'fas fa-home')]]")
      end
    end

    it 'can log out' do
      visit root_path

      fill_in 'username', with: 'test'
      fill_in 'password', with: 'password'

      click_on 'Sign in'

      expect(current_path).to eq(root_path)

      click_on 'Sign out'

      expect(current_path).to eq(root_path)
      expect(page).to_not have_content('test')
      expect(page).to_not have_css("footer")
      expect(page).to_not have_css("nav")
    end
  end
end
