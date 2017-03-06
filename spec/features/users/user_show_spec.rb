require 'rails_helper'

RSpec.feature 'User profile page', :type => :feature do
  let(:user) { FactoryGirl.create(:user) }

  before(:each) { visit user_path(user) }

  scenario 'has link to journal' do
    click_link 'Journal'
    expect(current_path).to eq(journal_path(user))
  end

  scenario 'has link to places' do
    click_link 'Places'
    expect(current_path).to eq(user_path(user))
  end

  scenario "displays that user has no places if none exist" do
    expect has_content?("no places")
  end

  scenario "lists user's places" do
    place = FactoryGirl.create(:place, user: user)
    expect has_content?(place.name)
  end

  scenario 'links to followers' do
    expect has_link? followers_path(user)
  end

  scenario 'links to following' do
    expect has_link? following_path(user)
  end


  context 'logged in' do

    before do
      sign_in(user.email, user.password)
      visit user_path(user)
    end

    context 'own page' do
      scenario 'has link to edit profile' do
        click_link 'Edit Profile'
        expect(current_path).to eq(edit_user_registration_path)
      end

      scenario 'has link to create new place' do
        expect has_link? new_place_path
      end

      context 'places' do
        scenario 'can create a new place' do
          click_on 'new-place'
          fill_in 'Name', with: 'Greece'
          click_on 'Create Place'
          expect(user.places.count).to eq(1)
        end

        scenario 'clicking place shows posts' do
          pending
          place = FactoryGirl.create(:place, name: 'America')
          visit user_path(user)
          click_on place_path(place)   
          expect has_content? 'America'       
        end
      end

      scenario 'can create a new journal entry' do
        click_on 'Journal'
        click_on 'New Journal Entry'
        fill_in 'Title', with: 'This is a cool title!'
        fill_in 'Content', with: 'and some pretty cool content to match my title!'
        click_on 'Create Entry'
        expect(user.entries.count).to eq(1)
      end
    end

    context "other user's page" do
      let(:user_2) { FactoryGirl.create(:user) }

      before { visit user_path(user_2) }

      scenario 'has link to follow user if not following' do
        expect has_link? 'Follow'
      end

      scenario 'does not have unfollow link if user is not following' do
        click_link 'Follow'
        visit user_path(user_2)
        click_link 'Unfollow' # making sure unfollow is clicked at least once
        expect has_no_link? 'Unfollow'
      end

      scenario 'has link to unfollow user if already following' do
        click_link 'Follow'
        expect has_link? 'Unfollow'
      end

      scenario 'does not have follow link if user is already following' do
        click_link 'Follow'
        expect has_no_link? 'Follow'
      end

      scenario 'does not have link to add new place' do
        expect has_no_link? new_place_path
      end
    end
  end

  context 'not logged in' do

    scenario 'does not have follow link' do
      expect has_no_link? 'Follow'
    end

    scenario 'does not have unfollow link' do
      expect has_no_link? 'Unfollow'
    end

    scenario 'does not have link to add new place' do
      expect has_no_link? new_place_path
    end

  end

end