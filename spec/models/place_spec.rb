require 'rails_helper'

# Tests the basic associations of the place model.
RSpec.describe Place, type: :model do
  before(:each) do
    @user = User.create(first_name: "Rory", last_name: 'Gilmore', email: 'rory@starshollow.com', password: 'logan4lyfe', password_confirmation: 'logan4lyfe')
    @place = Place.create
    @user.places << @place
  end

  it "belongs to a user" do
    expect(@place.user_id).to eq(@user.id)
  end

  it "has many posts" do
    @place.posts.create
    expect(@place.posts.length).to eq(1)
  end
end