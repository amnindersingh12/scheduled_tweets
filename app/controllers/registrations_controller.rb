class RegistrationsController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to root_path, notice: "Thank you for signing up!" 
        else
            render :new, status: :unprocessable_entity
        end
   
    end
    def user_params
        params.require(:user).permit(:profile_image,:firstName, :username, :email, :password, :password_confirmation)

    end
end