class TweetsController < ApplicationController
  include ActionView::Helpers::DateHelper

  before_action :authenticate_user!

  def index
    @tweet = Tweet.new
    @tweets = Tweet.all.order(created_at: :desc)
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    if @tweet.save
      redirect_to tweet_all_path, notice: "Tweet created!"
    else
      redirect_to root_path, alert: "Tweet not created!"
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
    @user = User.find(@tweet.user_id)
    @date_time = time_ago_in_words(@tweet.created_at)
  end

  def destroy
    if current_user.id == Tweet.find(params[:id]).user_id
      Tweet.find(params[:id]).destroy
      redirect_to tweet_all_path, notice: "Tweet deleted!"
    else
      redirect_to tweet_all_path, alert: "You are not authorized to delete this tweet!"
    end
  end

  def tweet_params
    params.require(:tweet).permit(:body)
  end
end
