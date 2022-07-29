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
        format.html { redirect_to tweets_path, notice: "Tweet created!" }
      else
        format.html { redirect_to root_path, notice: "Tweet not created!, Please see the logs:#{@tweet.errors.full_messages}" }
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
    respond_to do |format|
      if current_user.id == Tweet.find(params[:id]).user_id
        Tweet.find(params[:id]).destroy
        format.html { redirect_to tweets_path, notice: "Tweet deleted!" }
      else
        format.html { redirect_to tweets_path, alert: "You are not authorized to delete this tweet!" }
      end
    end
  end

  def tweet_params
    params.require(:tweet).permit(:body, :tweet_id)
  end
end
