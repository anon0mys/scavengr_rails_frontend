require 'rails_helper'

feature 'A logged in user' do
  context 'on a specific user\'s scavenger_hunts page' do
    scenario 'can see that user\'s scavenger hunts' do

    end
  end

  context 'on their own scavenger_hunts page' do
    scenario 'can see their scavenger hunts with edit and delete buttons' do
      attrs = { id: 1, username: 'username', email: 'test@mail.com', token: 'token' }
      user = User.new(attrs)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      stub_request(:get, "https://scavengr-django.herokuapp.com/api/v1/users/#{user.username}/scavenger_hunts/")
      .to_return(status: 200, body: File.read('./spec/fixtures/json/user_scavenger_hunts.json'))

      visit "/#{user.username}/scavenger_hunts"

      expect(page).to have_content "#{user.username}\'s Scavenger Hunts"
      expect(page).to have_css('.scavenger-hunt-card', count: 10)
      expect(page).to have_content 'Scavenger Hunt 1'
      expect(page).to have_content 'Testing the ability to add hunts'
      expect(page).to have_button 'Edit'
      expect(page).to have_button 'Delete'
    end
  end
end
