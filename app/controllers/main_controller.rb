class MainController < ApplicationController
    def index
        flash.now[:notice] = "Welcome to the site!"
        flash.now[:alert] = "Beware of Hackers!"
    end
end
