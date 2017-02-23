require 'rails_helper'

RSpec.describe Entry, type: :model do
  before(:each) do
    @user = User.create
    @entry = Entry.create
    @user.entries << @entry
  end

  it "belongs to a user" do
    expect(@entry.user).to eq(@user)
  end
end