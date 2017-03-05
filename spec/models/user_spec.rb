require 'rails_helper'

# Tests the basic associations of the user model.
RSpec.describe User, type: :model do
  before(:each) do
    @user1 = FactoryGirl.create(:user)
    @user2 = FactoryGirl.create(:user)
  end

  it { should have_many(:entries) }

  it { should have_many(:places) }

  it { should have_many(:follower_relationships) }

  it { should have_many(:following_relationships) }

  # Tests the full_name method of user
  describe ".full_name" do
    it 'should return user first_name and last_name' do
      expect(@user1.full_name).to eq("#{@user1.first_name} " + "#{@user1.last_name}")
    end
  end

  context 'user1 follows user2' do
    before(:each) { @user1.follow(@user2.id) }

    # Tests the follow method of the User model.
    describe ".follow" do

      # Tests that when one user follows another, the user.following
      # array contains the followed user
      it "follows a user" do
        expect(@user1.following).to include(@user2)
      end

      # Tests that when one user follows another, the followed 
      # user.follower array contains the following user
      it "makes self a follower of the followed user" do
        expect(@user2.followers).to include(@user1)
      end 
    end

    # Tests the unfollow method of the User model.
    describe ".unfollow" do
      before(:each) { @user1.unfollow(@user2.id) }

      # Tests that when one user unfollows another, the user.following
      # array no longer contains the unfollowed user
      it "unfollows a user" do
        expect(@user1.following).to_not include(@user2)
      end

      # Tests that when one user unfollows another, the followed 
      # user.follower array no longer contains the unfollowing user
      it "removes self as a follower of the followed user" do
        expect(@user2.followers).to_not include(@user1)
      end 
    end

    # Tests the following? method of the User model.
    describe ".following?" do

      # Tests that when one user follows another, the following?
      # method returns true if user.following contains the followed user
      it "returns true if a user is following the given user" do
        expect(@user1).to be_following(@user2.id)
      end
    end

    # Tests the followers? method of the User model.
     describe ".followers?" do

      # Tests that when one user follows another, the followers?
      # method returns true if user.followers contains the following user
      it "returns true if a user is following the given user" do
        expect(@user2).to be_followers(@user1.id)
      end
    end
  end

  # Tests the search class method of User class.
  describe '#search' do
    before(:each) do
      @user1.update(first_name: "Rory", last_name: 'Gilmore', email: 'rory@starshollow.com')
      @user2.update(first_name: "Logan", last_name: "Huntzberger", email: 'logan@huntzberger.com')
    end

    # Tests that if no users match the search, no users will be returned
    it 'does not return any users if none match' do
      search = User.search('Alice')
      expect(search.count).to eq(0)
    end

    # Tests that if a user does match the search, it returns ONLY the users that match
    it "returns users that match search terms and none that don't" do
      search = User.search('Rory')
      expect(search).to include(@user1)
      expect(search).to_not include(@user2)
    end

    # Tests that if multiple users match the search, they are all returned
    it 'can return multiple users if they match' do
      search = User.search('a')
      expect(search).to include(@user1)
      expect(search).to include(@user2)
    end

    # Tests that the search terms are compared to first name
    it 'returns user if first name matches the search terms' do
      search = User.search('Rory')
      expect(search).to include(@user1)
    end

    # Tests that search terms are compared to last name
    it 'returns user if last name matches the search terms' do
      search = User.search('Gilmore')
      expect(search).to include(@user1)
    end

    # Tests that search terms are compared to email
    it 'returns user if email matches the search terms' do
      search = User.search('logan@huntzberger.com')
      expect(search).to include(@user2)
    end

  end

end