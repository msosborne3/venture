require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:each) do
    @user = User.create(first_name: "Rory", last_name: 'Gilmore', email: 'rory@starshollow.com', password: 'logan4lyfe', password_confirmation: 'logan4lyfe')
    @entry = @user.entries.build()
    @comment = @entry.comments.build(user_id: @user.id)
  end

  it "belongs to a user" do
    expect(@comment.user).to eq(@user)
  end

  it "belongs to entry" do
    expect(@comment.entry).to eq(@entry)
  end
end