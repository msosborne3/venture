require 'rails_helper'

RSpec.describe Entry, type: :model do
  before(:each) do
    @user = User.create
    @entry = Entry.create
    @user.entries << @entry
    @entry.comments.build()
  end

  it "belongs to a user" do
    expect(@entry.user).to eq(@user)
  end

  it "has many comments" do
    expect(@entry.comments.length).to eq(1)
  end
end