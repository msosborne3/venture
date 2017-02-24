class WelcomeController < ApplicationController
  # Displays the homepage. Sets the following_entries array equal
  # to all of the entries of users that the current user follows
  def home
    if current_user
      @entries = Entry.of_followed_users(current_user.following).order('created_at DESC')
    else
      @entries = Entry.all
    end
  end
end
