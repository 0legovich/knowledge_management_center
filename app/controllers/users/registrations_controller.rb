class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

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
      redirect_to after_update_path_for(@user)
    else
      render "edit"
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

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

# The path used after sign up.
# def after_sign_up_path_for(resource)
#   super(resource)
# end

# The path used after sign up for inactive accounts.
# def after_inactive_sign_up_path_for(resource)
#   super(resource)
# end
end
