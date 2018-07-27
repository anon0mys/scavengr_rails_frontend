require 'rails_helper'

feature 'A visitor' do
  context 'can create an account' do
    scenario 'and is successfully logged in' do
      expected = {:id=>2, :email=>"test@mail.com", :token=>"test", username: 'test' }

      stub_request(:post, 'https://scavengr-django.herokuapp.com/api/v1/users/')
      .to_return(status: 201, body: expected.to_json)

      visit '/'

      click_on 'Register'

      expect(current_path).to eq(create_account_path)

      fill_in 'username', with: 'test'
      fill_in 'email', with: 'test@mail.com'
      fill_in 'password', with: 'password'
      click_on 'Submit'

      expect(current_path).to eq(root_path)
      expect(page).to have_content('test')
      # expect(page).to have_content('Log Out')
    end
  end
end
