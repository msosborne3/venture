class Place < ApplicationRecord
  has_many :posts
  belongs_to :user

  # Finds place where search term matches name
  def self.search(search)
    where("name LIKE ?", "%#{search}%") 
  end
end
