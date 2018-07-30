require 'rails_helper'

feature 'A visitor' do
  context 'can create an account' do
    scenario 'and is successfully logged in' do
      expected = {:id=>2, :email=>"user@mail.com", :token=>"test", username: 'user' }

      visit '/'

      click_on 'Register'

      expect(current_path).to eq(create_account_path)

      fill_in 'username', with: 'user'
      fill_in 'email', with: 'user@mail.com'
      fill_in 'password', with: 'password'
      click_on 'Submit'

      expect(current_path).to eq(root_path)
      expect(page).to have_content('user')
      # expect(page).to have_content('Log Out')
    end
  end
end
