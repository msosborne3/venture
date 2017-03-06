require 'rails_helper'

RSpec.feature 'Edit User', :type => :feature do

  context 'not signed in with facebook' do
    scenario 'edits the current user' do
      user = FactoryGirl.create(:user, first_name: 'James')
      sign_in(user.email, user.password)
      click_on 'Profile'
      click_on 'Edit Profile'
      fill_in 'First name', with: 'John'
      fill_in 'Current password', with: user.password
      click_on 'Update'
      expect(User.first.first_name).to eq("John")
    end
  end

  context 'signed in with facebook' do
    scenario 'edits current user' do
      user = FactoryGirl.create(:facebook_user)
      sign_in(user.email, user.password)
      click_on 'Profile'
      click_on 'Edit Profile'
      fill_in 'First name', with: 'John'
      click_on 'Update'
      expect(User.first.first_name).to eq("John")
    end
  end
end