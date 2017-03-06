require 'rails_helper'

RSpec.feature 'Sign Up', :type => :feature do
  scenario 'can sign up successfully' do
    visit new_user_registration_path
    sign_up_with('Rory', 'Gilmore', 'random@example.com', 'password', 'password')
    expect has_link? "Sign Out"
  end
end