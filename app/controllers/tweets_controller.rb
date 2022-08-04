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
    respond_to do |format|
      if @tweet.save
        format.js { }
      end
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
    @comment = Comment.new
    @comments = @tweet.comments.order(created_at: :desc)
    @user = User.find(@tweet.user_id)
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    if current_user.id == Tweet.find(params[:id]).user_id
      Tweet.find(params[:id]).destroy
    end
    respond_to do |format|
      format.js { }
    end
  end

  def retweet
    @tweet = Tweet.find(params[:id])
    @retweet = current_user.tweets.new(tweet_id: @tweet.id)
    @retweet.body = "#{@tweet.body}"

    respond_to do |format|
      if @retweet.save
        format.js { }
      end
    end
  end

  def tweet_params
    params.require(:tweet).permit(:body, :tweet_id)
  end
end
