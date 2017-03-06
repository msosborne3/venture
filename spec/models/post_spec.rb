require 'rails_helper'

# Tests the basic associations of the user model.
RSpec.describe Post, type: :model do
  before do
    @post1 = FactoryGirl.create(:post)
    @post2 = FactoryGirl.create(:post)
  end

  it { should belong_to(:place) }

  # Tests the post_user method of the Post model.
  describe ".post_user" do

    # Tests that the post_user method returns the users who has the post
    # through the place
    it "returns the user who owns the place that owns the post" do
      @place = @post1.place
      @user = @place.user
      expect(@post1.post_user).to be(@user)
    end
  end

  # Tests the search method of the Post model.
  describe "#search" do
    before(:each) do
      @post1.update(description: "Awesome Greece!", link: 'www.greece-is-awesome.com')
      @post2.update(description: "Awesome Statue of Liberty", link: "www.liberty.com")
    end

    # Tests that if no posts match the search, no posts will be returned
    it 'does not return any posts if none match' do
      search = Post.search('America')
      expect(search.count).to eq(0)
    end

    # Tests that if a post does match the search, it returns ONLY the posts that match
    it "returns posts that match search terms and none that don't" do
      search = Post.search('Greece')
      expect(search).to include(@post1)
      expect(search).to_not include(@post2)
    end

    # Tests that if multiple posts match the search, they are all returned
    it 'can return multiple posts if they match' do
      search = Post.search('awesome')
      expect(search).to include(@post1)
      expect(search).to include(@post2)
    end

    # Tests that the search terms are compared to link
    it 'returns post if link matches the search terms' do
      search = Post.search('greece-is-awesome')
      expect(search).to include(@post1)
    end

    # Tests that search terms are compared to description
    it 'returns post if description matches the search terms' do
      search = Post.search('statue')
      expect(search).to include(@post2)
    end
  end
end