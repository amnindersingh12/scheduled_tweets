class TweetsController < ApplicationController
    before_action :authenticate_user

    def authenticate_user
        if session[:user_id]
            @current_user = User.find(session[:user_id])
        else
            redirect_to sign_in_path, notice: "You must be logged in to do that!"
        end
    end

    def new
        @tweet = Tweet.new
    end

    def create
        @tweet = Tweet.new(tweet_params)
        @tweet.user_id = @current_user.id

        if @tweet.save
            redirect_to root_path, notice: "Tweet created!"
        else
        
            render :new, status: :unprocessable_entity
        end
       
    end

    def tweet_params
        params.require(:tweet).permit(:body)

        
        
    end

    def index
        @tweets = Tweet.all
    end

    def show
        @tweet = Tweet.find(params[:id])
    end

    


end
