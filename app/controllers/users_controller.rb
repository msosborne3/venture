class UsersController < ApplicationController
  # Displays a user's profile page
  def show
    @user = User.find(params[:id])
  end
end
