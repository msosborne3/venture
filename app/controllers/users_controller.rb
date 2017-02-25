class UsersController < ApplicationController
  before_action :set_user, only: [:show, :following, :followers, :journal, :places]

  def index
    @users = User.all
    if params[:search]
      @users = User.search(params[:search]).order("created_at DESC")
    else
      @users = User.all.order("created_at DESC")
    end
  end
  
  # Displays a user's profile page
  def show
    @places = @user.places.order("created_at asc")
  end

  def following
    @following = @user.following
  end

  def followers
    @followers = @user.followers
  end

  def journal
    @entries = @user.entries.order("created_at desc")
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
