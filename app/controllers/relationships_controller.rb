class RelationshipsController < ApplicationController
  def follow_user
    @user = User.find(params[:id])
    if current_user.follow(@user.id)
      redirect_to '/'
    end
  end

  def unfollow_user
    @user = User.find(params[:id])
    if current_user.unfollow(@user.id)
      redirect_to '/'
    end
  end
end
