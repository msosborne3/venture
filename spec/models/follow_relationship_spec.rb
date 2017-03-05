require 'rails_helper'

RSpec.describe FollowRelationship, type: :model do
  before(:each) do
    @user1 = User.create
    @user2 = User.create
    @relationship = FollowRelationship.create(follower_id: @user1.id, following_id: @user2.id)
  end
  
  it {should belong_to(:follower) }

  it { should belong_to(:following) }
end