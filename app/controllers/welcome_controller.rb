class WelcomeController < ApplicationController
  def home
    @following_entries = Entry.of_followed_users(current_user.following).order('created_at DESC')
  end
end
