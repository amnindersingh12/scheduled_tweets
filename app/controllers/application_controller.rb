class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_user

  def set_current_user
    Current.user = current_user
  end
  layout :new_layout

  def new_layout
    if devise_controller?
      'devise'
    else
      'application'
    end
  end

  protected

  def configure_permitted_parameters
    attributes = %i[username first_name email password password_confirmation profile_image]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[email password])
  end
end
