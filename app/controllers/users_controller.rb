class UsersController < ApplicationController
  before_action :set_user
  
  # Displays a user's profile page
  def show
  end

  def following
    @following = @user.following
  end

  def followers
    @followers = @user.followers
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
