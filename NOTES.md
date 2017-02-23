#Venture

Users have accounts with log in/out sign up capability. - Devise, OmniAuth

Users follow other members, places
Users have followers
has many posts
has many places
has one journal
has many entries through journal


Place (board)
Place has many posts

Post
belongs to User
belongs to Place

Keyword
name:string
??


## Database

Journal
user_id:integer
- on second thought, I'm not sure journal needs to be its own model. Maybe to have followers, but for now users can only follow people.


-Entry
-journal_id:integer

Entry
user_id:integer
title:string
content:text

User
profile_picture: ? (use paperclip)
first_name:string
last_name:string
email:string

Followings
user_id:integer
follower_id:integer


Connection? (May use to join users)

Place
name:string
date created:datetime
created_by:integer

Post
name:string
image: ? (use paperclip)
user_id:integer
description:text
link:string


## Style
Each profile page lists all Places(boards)
Interactive Map at the top of each page that has pins in places traveled and different pins for places planning to travel


## Tips 
from stack overflow for dealing with followers based on twitter:

rails generate model Person name:string
rails generate model Followings person_id:integer follower_id:integer blocked:boolean

class Person < ActiveRecord::Base
  has_many :followers, :class_name => 'Followings', :foreign_key => 'person_id'
  has_many :following, :class_name => 'Followings', :foreign_key => 'follower_id' 
end

class Followings < ActiveRecord::Base
  belongs_to :person
  belongs_to :follower, :class_name => 'Person'
end


## Game Plan

Initially just set up the application with the journal functionality. Users can add journal posts.
They can follow people and see their journal posts.
User's own journal posts can be displayed on their own profile page.
Profile page has a settings feature that can edit profile information.

Add later: When a journal is created, it is associated with a specific location.
Add later: photo posts





