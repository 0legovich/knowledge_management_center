class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(
        :email,
        :first_name,
        :last_name,
        :username,
        :sex,
        :birthday,
        :password,
        :password_confirmation
      )
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  def after_sign_in_path_for(resource_or_scope)
    user_path(current_user)
  end
end
