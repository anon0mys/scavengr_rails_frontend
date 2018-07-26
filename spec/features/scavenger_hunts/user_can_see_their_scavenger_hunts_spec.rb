require 'rails_helper'

feature 'A logged in user' do
  context 'on a specific user\'s scavenger_hunts page' do
    scenario 'can see that user\'s scavenger hunts' do

    end
  end

  context 'on their own scavenger_hunts page' do
    scenario 'can see their scavenger hunts with edit and delete buttons' do
      attrs = { id: 1, username: 'test', email: 'test@mail.com', token: '56963da5d3ab5155ae8f40fc3612f3a1986a5f38' }
      user = User.new(attrs)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/test/scavenger_hunts'

      expect(page).to have_content 'Test'
    end
  end
end
