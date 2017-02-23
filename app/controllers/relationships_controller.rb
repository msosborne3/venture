class RelationshipsController < ApplicationController

  # follows a user by finding the given user and passing
  # its id to the follow method for current user.
  def follow_user
    @user = User.find(params[:id])
    if current_user.follow(@user.id)
      redirect_to '/'
    end
  end

  # unfollows a user by finding the given user and passing
  # its id to the unfollow method for current user.
  def unfollow_user
    @user = User.find(params[:id])
    if current_user.unfollow(@user.id)
      redirect_to '/'
    end
  end
end
