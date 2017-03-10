class Place < ApplicationRecord
  has_many :posts
  belongs_to :user

  scope :of_followed_users, -> (following_users) { where user_id: following_users }  

  # Finds place where search term matches name
  def self.search(search)
    where("name ILIKE ?", "%#{search}%") 
  end
end
