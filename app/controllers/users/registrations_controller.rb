class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # PUT /resource
  def update
    if account_update_params[:password].blank?
      update = true if @user.update_without_password(account_update_params)
    else
      update = true if @user.update(account_update_params)
    end

    if update
      set_flash_message :notice, :updated
      sign_in @user, bypass: true
      redirect_to user_path(@user)
    else
      render "edit"
    end
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    attributes = [:first_name, :last_name, :patronymic, :birthday, :sex, :email, :password, :password_confirmation]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    attributes = [:first_name, :last_name, :patronymic, :birthday, :sex, :email, :password, :password_confirmation]
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end
end
