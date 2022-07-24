class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  

  def require_login
    if !user_signed_in?
      redirect_to new_user_session_path
    end
  end

  protected

  def configure_permitted_parameters
    attributes = [:username, :first_name, :email, :password, :password_confirmation, :profile_image]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  end
end
