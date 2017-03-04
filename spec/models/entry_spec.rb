require 'rails_helper'

RSpec.describe Entry, type: :model do
  before do
    @user = User.create(first_name: "Rory", last_name: 'Gilmore', email: 'rory@starshollow.com', password: 'logan4lyfe', password_confirmation: 'logan4lyfe')
    @entry = @user.entries.build
  end

  it "belongs to a user" do
    expect(@entry.user).to eq(@user)
  end

  it "has many comments" do
    @entry.comments.build
    expect(@entry.comments.length).to eq(1)
  end

  # Tests the search class method of Entry class.
  describe '#search' do
    before do
      @entry1 = Entry.create(title: "Greece is awesome")
      @entry2 = Entry.create(title: "Checkout my trip to New York!")
      @user.entries << [@entry1, @entry2]
    end

    # Tests that if no entries match the search, no entries will be returned
    it 'does not return any entries if none match' do
      search = Entry.search('America')
      expect(search.count).to eq(0)
    end

    # Tests that if an entry does match the search, it returns ONLY the entry
    it 'returns entries that match search terms' do
      search = Entry.search('Greece')
      expect(search).to include(@entry1)
      expect(search).to_not include(@entry2)
    end
  end
end