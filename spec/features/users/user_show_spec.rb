require 'rails_helper'

RSpec.feature 'User profile page', :type => :feature do
  let(:user) { FactoryGirl.create(:user) }

  scenario 'has link to journal' do
    visit user_path(user)
    click_link 'Journal'
    expect(current_path).to eq(journal_path(user))
  end

  scenario 'has link to places' do
    visit user_path(user)
    click_link 'Places'
    expect(current_path).to eq(user_path(user))
  end

  context 'logged in' do

    before do
      sign_in(user.email, user.password)
    end

    scenario 'own page has link to edit profile' do
      visit user_path(user)
      click_link 'Edit Profile'
      expect(current_path).to eq(edit_user_registration_path)
    end

  end

end