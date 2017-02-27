require 'rails_helper'

# Tests the basic associations of the user model.
RSpec.describe Place, type: :model do
  before(:each) do
    # Create a user, place, and post to test the features
    @user = User.create(first_name: "Rory", last_name: 'Gilmore', email: 'rory@starshollow.com', password: 'logan4lyfe', password_confirmation: 'logan4lyfe')
    @place = @user.places.build
    @post = @place.posts.build
  end

  it "belongs to a place" do
    expect(@post.place_id).to eq(@place.id)
  end

  # Tests the post_user method of the Post model.
  describe ".post_user" do

    before(:each) do
      # Create a user, place, and post to test the features
      @user = User.create(first_name: "Rory", last_name: 'Gilmore', email: 'rory@starshollow.com', password: 'logan4lyfe', password_confirmation: 'logan4lyfe')
      @place = @user.places.build
      @post = @place.posts.build
    end

    # Tests that the post_user method returns the users who has the post
    # through the place
    it "returns the user who owns the place that owns the post" do
      expect(@post.post_user).to be(@user)
    end
  end
end