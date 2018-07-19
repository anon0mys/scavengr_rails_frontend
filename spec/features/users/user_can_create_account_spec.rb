require 'rails_helper'

describe 'A visitor' do
  context 'can create an account' do
    scenario 'and is successfully logged in' do
      visit '/'

      click_on 'Create Account'

      expect(current_path).to eq(create_account_path)

      fill_in 'user[email]', with: 'test@mail.com'
      fill_in 'user[password]', with: 'password'
      click_on 'Create Account'

      expect(current_path).to eq(root_path)
      expect(page).to have_content('Logged in as: test@mail.com')
    end
  end
end
