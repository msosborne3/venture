class RegistrationsController < Devise::RegistrationsController

  private

  # adds first_name and last_name to Devise's original sign up paramaters
  
  def sign_up_params
    params.require(:user).permit(:profile_picture, :first_name, :last_name, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:profile_picture, :first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  end

  # Overwrite update_resource to let users to update their user without giving their password
  def update_resource(resource, params)
    if current_user.provider == "facebook"
      params.delete("current_password")
      resource.update_without_password(params)
    else
      resource.update_with_password(params)
    end
  end
end