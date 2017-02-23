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

end