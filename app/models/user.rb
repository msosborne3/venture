class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:facebook]

  has_many :entries, dependent: :destroy
  has_many :follower_relationships, foreign_key: :following_id, class_name: 'FollowRelationship'
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :following_relationships, foreign_key: :follower_id, class_name: 'FollowRelationship'
  has_many :following, through: :following_relationships, source: :following

  has_many :comments, dependent: :destroy

  has_many :places
  has_many :posts, :through => :places

  has_attached_file :profile_picture, default_url: ':style/default.png', styles: { :small => "45x45#", :thumb => "80x80#", :medium => "140x140#"}
  validates_attachment_content_type :profile_picture, content_type: /\Aimage\/.*\z/

  attr_reader :profile_picture_remote_url


  # Follows a user by setting the following_id to the given user
  # and the follower_id to the id of this User object
  def follow(user_id)  
    following_relationships.create(following_id: user_id, follower_id: self.id)
  end

  # Unfollows a user by destroying the relationship
  def unfollow(user_id)
    following_relationships.find_by(following_id: user_id).destroy
  end

  # Determines whether or not the given user is being followed by
  # this User object. Returns true or false
  def following?(user_id)
    user = User.find_by(id: user_id)
    self.following.include?(user) ? true : false
  end

  # Determines whether or not the given user is a follower of
  # this User object. Returns true or false
  def followers?(user_id)
    user = User.find_by(id: user_id)
    self.followers.include?(user) ? true : false
  end

  # Returns a users full name by adding the first and last names
  def full_name
    full_name = self.first_name + " " + self.last_name
  end

  # Finds user where search term matches first_name, last_name, or email
  def self.search(search)
    where("first_name LIKE ? OR last_name LIKE ? OR email LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%") 
  end

  # Gets information from facebook
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end      
  end

end
