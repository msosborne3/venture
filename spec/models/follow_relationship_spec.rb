require 'rails_helper'

RSpec.describe FollowRelationship, type: :model do
  before(:each) do
    @user1 = User.create
    @user2 = User.create
    @relationship = FollowRelationship.create(follower_id: @user1.id, following_id: @user2.id)
  end

  it "belongs to a follower" do
    expect(@relationship.follower_id).to eq(@user1.id)
  end

  it "belongs to a following user" do
    expect(@relationship.following_id).to eq(@user2.id)
  end
end