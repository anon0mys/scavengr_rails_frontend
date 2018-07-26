require 'rails_helper'

feature 'A logged in user' do
  context 'on their own scavenger_hunt show page' do
    scenario 'can see their scavenger hunt' do
      attrs = { id: 1, username: 'test', email: 'test@mail.com', token: '56963da5d3ab5155ae8f40fc3612f3a1986a5f38' }
      user = User.new(attrs)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/test/scavenger_hunts/1'

      expect(current_path).to eq '/test/scavenger_hunts/1'
      expect(page).to have_content 'Test Scavenger Hunt'
    end

    scenario 'can add a point to their scavenger hunt' do
    end
  end

  context 'when they navigate to another user\'s /username/scavenger_hunts/:id' do
    scenario 'they are redirected to /scavenger_hunts/:id' do
      attrs = { id: 1, username: 'test', email: 'test@mail.com', token: '56963da5d3ab5155ae8f40fc3612f3a1986a5f38' }
      user = User.new(attrs)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/user_2/scavenger_hunts/162'

      expect(current_path).to eq '/scavenger_hunts/162'
    end
  end
end
