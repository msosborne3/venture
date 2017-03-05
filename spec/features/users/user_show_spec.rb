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

  scenario "page displays that user has no places" do
    visit user_path(user)
    expect has_content?("no places")
  end

  context 'logged in' do
    let(:user_2) { FactoryGirl.create(:user) }

    before do
      sign_in(user.email, user.password)
    end

    context 'own page' do
      scenario 'has link to edit profile' do
        visit user_path(user)
        click_link 'Edit Profile'
        expect(current_path).to eq(edit_user_registration_path)
      end

      scenario 'has link to create new place' do
        visit user_path(user)
        expect has_link?(new_place_path)
      end
    end
  end

end