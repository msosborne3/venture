require 'rails_helper'

RSpec.feature 'Sign Out', :type => :feature do
  scenario 'user signs out successfully' do
    user = FactoryGirl.create(:user)
    sign_in(user.email, user.password)
    expect(current_path).to eq(root_path)
    click_link 'Sign Out'
    expect has_link?('Sign In')
  end
end