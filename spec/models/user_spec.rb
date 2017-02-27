require 'rails_helper'

# Tests the basic associations of the user model.
RSpec.describe User, type: :model do
  before(:each) do
    @user = User.create(first_name: "Rory", last_name: 'Gilmore', email: 'rory@starshollow.com', password: 'logan4lyfe', password_confirmation: 'logan4lyfe')
  end

  it "has many entries" do
    @user.entries.create
    expect(@user.entries.count).to be(1)
  end

  it "has many places" do
    @user.places.create
    expect(@user.places.count).to be(1)
  end

  it "has many follower_relationships" do
    @user.follower_relationships.create
    expect(@user.follower_relationships.length).to eq(1)
  end

  it "has many following_relationships" do
    @user.following_relationships.create
    expect(@user.following_relationships.length).to eq(1)
  end

  # Tests the follow method of the User model.
  describe ".follow" do

    before(:each) do
      # Create two users to test the following features
      @user1 = User.create(first_name: "Luke", last_name: "Danes", email: 'luke@starshollow.com', password: 'coffee', password_confirmation: "coffee")
      @user2 = User.create(first_name: "Logan", last_name: "Huntzberger", email: 'logan@huntzberger.com', password: 'coffee', password_confirmation: "coffee")
    end

    # Tests that when one user follows another, the user.following
    # array contains the followed user
    it "follows a user" do
      @user1.follow(@user2.id)
      expect(@user1.following).to include(@user2)
    end

    # Tests that when one user follows another, the followed 
    # user.follower array contains the following user
    it "makes self a follower of the followed user" do
      @user1.follow(@user2.id)
      expect(@user2.followers).to include(@user1)
    end 
  end

  # Tests the unfollow method of the User model.
  describe ".unfollow" do

    before(:each) do
      # Create two users to test the unfollowing features
      @user1 = User.create(first_name: "Luke", last_name: "Danes", email: 'luke@starshollow.com', password: 'coffee', password_confirmation: "coffee")
      @user2 = User.create(first_name: "Logan", last_name: "Huntzberger", email: 'logan@huntzberger.com', password: 'coffee', password_confirmation: "coffee")
    end

    # Tests that when one user unfollows another, the user.following
    # array no longer contains the unfollowed user
    it "unfollows a user" do
      @user1.follow(@user2.id)
      expect(@user1.following).to include(@user2)
      @user1.unfollow(@user2.id)
      expect(@user1.following).to_not include(@user2)
    end

    # Tests that when one user unfollows another, the followed 
    # user.follower array no longer contains the unfollowing user
    it "removes self as a follower of the followed user" do
      @user1.follow(@user2.id)
      expect(@user2.followers).to include(@user1)
      @user1.unfollow(@user2.id)
      expect(@user2.followers).to_not include(@user1)
    end 
  end

  # Tests the following? method of the User model.
  describe ".following?" do
    before(:each) do
      # Create two users to test the following features
      @user1 = User.create(first_name: "Luke", last_name: "Danes", email: 'luke@starshollow.com', password: 'coffee', password_confirmation: "coffee")
      @user2 = User.create(first_name: "Logan", last_name: "Huntzberger", email: 'logan@huntzberger.com', password: 'coffee', password_confirmation: "coffee")
    end

    # Tests that when one user follows another, the following?
    # method returns true if user.following contains the followed user
    it "returns true if a user is following the given user" do
      @user1.follow(@user2.id)
      expect(@user1.following?(@user2.id)).to be_truthy
    end
  end

  # Tests the followers? method of the User model.
   describe ".followers?" do
    before(:each) do
      # Create two users to test the following features
      @user1 = User.create(first_name: "Luke", last_name: "Danes", email: 'luke@starshollow.com', password: 'coffee', password_confirmation: "coffee")
      @user2 = User.create(first_name: "Logan", last_name: "Huntzberger", email: 'logan@huntzberger.com', password: 'coffee', password_confirmation: "coffee")
    end

    # Tests that when one user follows another, the followers?
    # method returns true if user.followers contains the following user
    it "returns true if a user is following the given user" do
      @user1.follow(@user2.id)
      expect(@user2.followers?(@user1.id)).to be_truthy
    end
  end

end