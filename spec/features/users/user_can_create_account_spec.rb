require 'rails_helper'

feature 'A visitor' do
  context 'can create an account' do
    scenario 'and is successfully logged in' do
      expected = { user: {:id=>2, :email=>"test@mail.com", :auth_token=>"test" }}
      stub_request(:post, 'https://scavengr-django.herokuapp.com/api/v1/users/')
        .to_return(status: 201, body: expected.to_json)

      visit '/'

      click_on 'Create Account'

      expect(current_path).to eq(create_account_path)

      fill_in 'email', with: 'test@mail.com'
      fill_in 'password', with: 'password'
      click_on 'Create Account'

      expect(current_path).to eq(root_path)
      expect(page).to have_content('Logged in as: test@mail.com')
    end
  end
end
