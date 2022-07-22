class ApplicationController < ActionController::Base

    before_action :set_current_user, :configure_permitted_parameters, if: :devise_controller?


    def set_current_user 
        if session[:user_id]
            Current.user = User.find_by(id: session[:user_id])
        end
    end

    def require_login
        if !Current.user
            redirect_to sign_in_path, notice: "You must be logged in to access this page."
        end

    end

    protected
    def configure_permitted_parameters
          devise_parameter_sanitizer.permit(:sign_up, keys: [:firstName,:username,:email,:password,:password_confirmation ])
    end   
end
