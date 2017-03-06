require 'rails_helper'

RSpec.describe FollowRelationship, type: :model do
  
  it {should belong_to(:follower) }

  it { should belong_to(:following) }
end