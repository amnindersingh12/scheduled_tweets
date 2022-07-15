class TweetsController < ApplicationController
    
    before_action :authenticate_user

    # rescue_from ActiveRecord::RecordNotFound, with: :help


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
        @tweet = Tweet.find(params[:id]) if params[:id]
    
    end

    # def help
    #     render plain: "4O4 Tweet Not Found !!"
    # end

    def destroy
        @tweet = Tweet.find(params[:id])
        @tweet.destroy
        redirect_to tweet_all_path, notice: "The Tweet was successfully destroyed."
      end 
end
