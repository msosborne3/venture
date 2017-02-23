class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  
  # Displays a user's profile page
  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      redirect_to controller: 'user', action: 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
