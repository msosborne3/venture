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

  scenario "displays that user has no places if none exist" do
    visit user_path(user)
    expect has_content?("no places")
  end

  scenario "lists user's places" do
    place = FactoryGirl.create(:place, user: user)
    visit user_path(user)
    expect has_content?(place.name)
  end

  context 'logged in' do

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
        expect has_link? new_place_path
      end
    end

    context "other user's page" do
      let(:user_2) { FactoryGirl.create(:user) }

      scenario 'has link to follow user if not following' do
        visit user_path(user_2)
        expect has_link? 'Follow'
      end

      scenario 'does not have unfollow link if user is not following' do
        visit user_path(user_2)
        expect has_no_link? 'Unfollow'
      end

      scenario 'has link to unfollow user if already following' do
        visit user_path(user_2)
        click_link 'Follow'
        expect has_link? 'Unfollow'
      end

      scenario 'does not have follow link if user is already following' do
        visit user_path(user_2)
        click_link 'Follow'
        expect has_no_link? 'Follow'
      end

      scenario 'does not have link to add new place' do
        visit user_path(user_2)
        expect has_no_link? new_place_path
      end
    end

  end

end