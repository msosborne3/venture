class Entry < ApplicationRecord
  belongs_to :user
  has_many :comments

  scope :of_followed_users, -> (following_users) { where user_id: following_users }  

  # Returns the user instance of the user that created the journal entry
  def entry_user
    User.find(self.user_id)
  end

  # Finds entry where search term matches title
  def self.search(search)
  where("title LIKE ?", "%#{search}%") 
  end

end
