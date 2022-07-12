class PasswordResetsController < ApplicationController
    def new
    end
    def create
      # haven't figured out how to get this to work yet
      flash[:notice] = "Please check your email for instructions to reset your password."
      redirect_to root_path
    end
    
end
