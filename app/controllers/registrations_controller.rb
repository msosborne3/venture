class RegistrationsController < Devise::RegistrationsController

  private

  # adds first_name and last_name to Devise's original sign up paramaters
  
  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  end
end