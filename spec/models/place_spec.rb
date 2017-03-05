require 'rails_helper'

# Tests the basic associations of the place model.
RSpec.describe Place, type: :model do
  before(:each) do
    @user = User.create(first_name: "Rory", last_name: 'Gilmore', email: 'rory@starshollow.com', password: 'logan4lyfe', password_confirmation: 'logan4lyfe')
    @place = Place.create
    @user.places << @place
  end

  it { should belong_to(:user) }
  
  it { should have_many(:posts) }

  # Tests the search class method of Place class.
  describe '#search' do
    before do
      @place1 = Place.create(name: "Greece")
      @place2 = Place.create(name: "New York")
      @user.places << [@place1, @place2]
    end

    # Tests that if no places match the search, no places will be returned
    it 'does not return any places if none match' do
      search = Place.search('America')
      expect(search.count).to eq(0)
    end

    # Tests that if a place does match the search, it returns ONLY the place
    it 'returns only places that match search terms' do
      search = Place.search('Greece')
      expect(search).to include(@place1)
      expect(search).to_not include(@place2)
    end
  end
end