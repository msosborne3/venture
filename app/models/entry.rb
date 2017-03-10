class Entry < ApplicationRecord
  belongs_to :user
  has_many :comments

  scope :of_followed_users, -> (following_users) { where user_id: following_users }  

  # Finds entry where search term matches title
  def self.search(search)
  where("title ILIKE ?", "%#{search}%") 
  end

end
