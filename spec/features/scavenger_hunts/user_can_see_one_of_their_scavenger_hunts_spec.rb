require 'rails_helper'

feature 'A logged in user', elasticsearch: true do
  context 'on their own scavenger_hunt show page' do
    scenario 'can see their scavenger hunt' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      scavenger_hunt = ScavengerHunt.new(name: 'Isyo hunt', description: 'Go on a nacho hunt')
      service = ScavengrBackend::ScavengerHunts.new(@user)
      service.create(scavenger_hunt)

      visit '/test/scavenger_hunts/1'

      expect(current_path).to eq '/test/scavenger_hunts/1'
      expect(page).to have_content 'Isyo hunt'
      expect(page).to have_content 'Go on a nacho hunt'
    end

    scenario 'can add a point to their scavenger hunt' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      scavenger_hunt = ScavengerHunt.new(name: 'Test Scavenger Hunt', description: 'Testing the ability to add hunts')
      service = ScavengrBackend::ScavengerHunts.new(@user)
      service.create(scavenger_hunt)

      visit '/test/scavenger_hunts/1'

      click_on 'Add a Point'

      expect(current_path).to eq new_scavenger_hunt_point_path(1)
    end
  end

  context 'when they navigate to another user\'s /username/scavenger_hunts/:id' do
    scenario 'they are redirected to /scavenger_hunts/:id' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      user = User.new(email: 'different_user@test.com', password: 'password', username: 'different_user')
      service = ScavengrBackend::Users.new()
      response = service.create(user)
      user = User.new(response)

      scavenger_hunt = ScavengerHunt.new(name: 'Nacho Hunt', description: 'This is not your hunt')
      service = ScavengrBackend::ScavengerHunts.new(user)
      service.create(scavenger_hunt)

      visit '/different_user/scavenger_hunts/1'

      expect(current_path).to eq '/scavenger_hunts/1'
    end
  end
end
