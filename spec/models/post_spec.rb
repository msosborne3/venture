require 'rails_helper'

# Tests the basic associations of the user model.
RSpec.describe Post, type: :model do
  before do
    @post = FactoryGirl.create(:post)
    @place = @post.place
    @user = @place.user
  end

  it { should belong_to(:place) }

  # Tests the post_user method of the Post model.
  describe ".post_user" do

    # Tests that the post_user method returns the users who has the post
    # through the place
    it "returns the user who owns the place that owns the post" do
      expect(@post.post_user).to be(@user)
    end
  end
end