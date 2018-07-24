require 'rails_helper'

feature 'A logged in user' do
  scenario 'can edit a scavenger hunt' do
    attrs = { id: 1, username: 'test', email: 'test@mail.com', token: '56963da5d3ab5155ae8f40fc3612f3a1986a5f38' }
    user = User.new(attrs)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit edit_scavenger_hunt_path(1)

    fill_in 'scavenger_hunt[name]', with: 'Changed'
    fill_in 'scavenger_hunt[description]', with: 'Changed description'

    click_on 'Update Scavenger Hunt'

    expect(current_path).to eq(scavenger_hunt_path(1))
    expect(page).to have_content('Changed')
    expect(page).to have_content('Changed description')
  end
end
