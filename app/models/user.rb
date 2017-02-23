class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :entries
  has_many :follower_relationships, foreign_key: :following_id, class_name: 'FollowRelationship'
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :following_relationships, foreign_key: :follower_id, class_name: 'FollowRelationship'
  has_many :following, through: :following_relationships, source: :following

  def follow(user_id)  
    following_relationships.create(following_id: user_id, follower_id: self.id)
  end

  def unfollow(user_id)
    following_relationships.find_by(following_id: user_id).destroy
  end

  def following?(user_id)
    user = User.find_by(id: user_id)
    self.following.include?(user) ? true : false
  end
end
