class Users::RegistrationsController < Devise::RegistrationsController
  def edit
  end

  def update
    if resource.update_with_password(resource_params)
      set_flash_message :notice, :updated
      sign_in resource_name, resource, :bypass => true
      redirect_to after_update_path_for(resource)
    else
      clean_up_passwords(resource)
      redirect_to after_update_path_for(resource)
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
        debugger
      end
    end
  end

  protected

  def after_update_path_for(resource)
    settings_path
  end

  def update_resource(resource, params)
    if (params[:current_password])
      resource.update_with_password(params)
    else
      resource.update_without_password(params)
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  end

  def resource_params
    params.require(:user).permit(:password, :current_password)
  end
end