class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :entries
  has_many :followers, :class_name => 'Followings', :foreign_key => 'user_id'
  has_many :following, :class_name => 'Followings', :foreign_key => 'follower_id' 
end
