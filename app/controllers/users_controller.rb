class UsersController < ApplicationController
  before_action :set_user, only: [:show, :following, :followers, :journal, :places]

  # Displays all users
  def index
    @users = User.all
  end
  
  # Displays a user's profile page
  def show
    @places = @user.places.order("created_at asc")
  end

  # displays a page of users that the given user is following
  def following
    @following = @user.following
  end

  # displays a page of users that are following a given user
  def followers
    @followers = @user.followers
  end

  # returns all of a user's journal entries
  def journal
    @entries = @user.entries.order("created_at desc")
  end

  private

  # Finds the specific user from the id sent through params
  def set_user
    @user = User.find(params[:id])
  end
end
