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

Entry
journal_id:integer

User
profile_picture: ?
first_name:string
last_name:string
email:string
journal_id:integer

Connection? (May use to join users)

Place
name:string
date created:datetime
created_by:integer

Post
name:string
content: ?
user_id:integer
description:text
link: ?


## Style
Each profile page lists all Places(boards)
Interactive Map at the top of each page that has pins in places traveled and different pins for places planning to travel
