require 'rails_helper'

RSpec.feature 'Sign In', :type => :feature do
  scenario 'cannot sign in if not registered' do
    sign_in('random@example.com', 'password')
    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'can sign in if registered' do
    user = FactoryGirl.create(:user)
    sign_in(user.email, user.password)
    expect(current_path).to eq(root_path)
  end
end