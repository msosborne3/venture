require 'rails_helper'

# Tests the basic associations of the user model.
RSpec.describe Place, type: :model do
  let(:user) { User.create(first_name: "Rory", last_name: 'Gilmore', email: 'rory@starshollow.com', password: 'logan4lyfe', password_confirmation: 'logan4lyfe') }
  let(:place) { user.places.build }
  subject(:post) { place.posts.build }

  it { should belong_to(:place) }

  # Tests the post_user method of the Post model.
  describe ".post_user" do

    # Tests that the post_user method returns the users who has the post
    # through the place
    it "returns the user who owns the place that owns the post" do
      expect(post.post_user).to be(user)
    end
  end
end