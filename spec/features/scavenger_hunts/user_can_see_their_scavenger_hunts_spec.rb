require 'rails_helper'

feature 'A logged in user' do
  context 'on a specific user\'s scavenger_hunts page' do
    scenario 'can see that user\'s scavenger hunts' do

    end
  end

  context 'on their own scavenger_hunts page' do
    scenario 'can see their scavenger hunts with edit and delete buttons' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      service = ScavengrBackend::ScavengerHunts.new(@user)

      (0...10).each do |num|
        scavenger_hunt = ScavengerHunt.new(name: "Scavenger Hunt #{num}", description: 'Testing the ability to add hunts')
        service.create(scavenger_hunt)
      end

      visit "/#{@user.username}/scavenger_hunts"

      expect(page).to have_content "#{@user.username}\'s Scavenger Hunts"
      expect(page).to have_css('.scavenger-hunt-card', count: 10)
      expect(page).to have_content 'Scavenger Hunt 1'
      expect(page).to have_content 'Testing the ability to add hunts'
      expect(page).to have_xpath(".//a[i[contains(@class, 'fas fa-edit')]]")
      expect(page).to have_xpath(".//a[i[contains(@class, 'fas fa-trash')]]")
    end
  end
end
