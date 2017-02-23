require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.create(first_name: "Rory", last_name: 'Gilmore', email: 'rory@starshollow.com', password: 'logan4lyfe', password_confirmation: 'logan4lyfe')
  end

  it "has many entries" do
    @user.entries.create
    expect(@user.entries.count).to be(1)
  end

  it "has many follower_relationships" do
    @user.follower_relationships.create
    expect(@user.follower_relationships.length).to eq(1)
  end

  it "has many following_relationships" do
    @user.following_relationships.create
    expect(@user.following_relationships.length).to eq(1)
  end

  describe ".follow" do

    before(:each) do
      @user1 = User.create(first_name: "Luke", last_name: "Danes", email: 'luke@starshollow.com', password: 'coffee', password_confirmation: "coffee")
      @user2 = User.create(first_name: "Logan", last_name: "Huntzberger", email: 'logan@huntzberger.com', password: 'coffee', password_confirmation: "coffee")
    end

    it "follows a user" do
      @user1.follow(@user2.id)
      expect(@user1.following).to include(@user2)
    end

    it "makes self a follower of the followed user" do
      @user1.follow(@user2.id)
      expect(@user2.followers).to include(@user1)
    end 
  end

  describe ".unfollow" do

    before(:each) do
      @user1 = User.create(first_name: "Luke", last_name: "Danes", email: 'luke@starshollow.com', password: 'coffee', password_confirmation: "coffee")
      @user2 = User.create(first_name: "Logan", last_name: "Huntzberger", email: 'logan@huntzberger.com', password: 'coffee', password_confirmation: "coffee")
    end

    it "unfollows a user" do
      @user1.follow(@user2.id)
      expect(@user1.following).to include(@user2)
      @user1.unfollow(@user2.id)
      expect(@user1.following).to_not include(@user2)
    end

    it "removes self as a follower of the followed user" do
      @user1.follow(@user2.id)
      expect(@user2.followers).to include(@user1)
      @user1.unfollow(@user2.id)
      expect(@user2.followers).to_not include(@user1)
    end 
  end

  describe ".following?" do
    before(:each) do
      @user1 = User.create(first_name: "Luke", last_name: "Danes", email: 'luke@starshollow.com', password: 'coffee', password_confirmation: "coffee")
      @user2 = User.create(first_name: "Logan", last_name: "Huntzberger", email: 'logan@huntzberger.com', password: 'coffee', password_confirmation: "coffee")
    end

    it "returns true if a user is following the given user" do
      @user1.follow(@user2.id)
      expect(@user1.following?(@user2.id)).to be_truthy
    end
  end

   describe ".followers?" do
    before(:each) do
      @user1 = User.create(first_name: "Luke", last_name: "Danes", email: 'luke@starshollow.com', password: 'coffee', password_confirmation: "coffee")
      @user2 = User.create(first_name: "Logan", last_name: "Huntzberger", email: 'logan@huntzberger.com', password: 'coffee', password_confirmation: "coffee")
    end

    it "returns true if a user is following the given user" do
      @user1.follow(@user2.id)
      expect(@user2.followers?(@user1.id)).to be_truthy
    end
  end

end