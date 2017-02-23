class Entry < ApplicationRecord
  belongs_to :user

  scope :of_followed_users, -> (following_users) { where user_id: following_users }  

  def entry_user
    User.find(self.user_id)
  end

end
