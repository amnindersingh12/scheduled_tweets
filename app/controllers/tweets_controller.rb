class TweetsController < ApplicationController
    include ActionView::Helpers::DateHelper

    before_action :authenticate_user!
  

    def new
        @tweet = Tweet.new
    end

    def create
        @tweet = Tweet.new(tweet_params)
        @tweet.user_id = @current_user.id

        if @tweet.save
            redirect_to root_path, notice: "Tweet created!"
        else
            redirect_to root_path, status: :unprocessable_entity
        end
       
    end



    def index
        @tweets = Tweet.all.order(created_at: :desc)
    end

    def show
        @tweet = Tweet.find(params[:id]) if params[:id]
        @date_time = time_ago_in_words(@tweet.created_at)

    
    end


    def destroy
        @tweet = Tweet.find(params[:id])
        @tweet.destroy
        redirect_to tweet_all_path, notice: "The Tweet was successfully destroyed."
      end 

    private
    def tweet_params
        params.permit(:body)
    end
end
