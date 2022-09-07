class TweetsController < ApplicationController
  include ActionView::Helpers::DateHelper
  include ApplicationHelper
  before_action :authenticate_user!
  before_action :setup_tweet, only: %i[retweet show reply]

  def create
    @tweet = Current.user.tweets.new(tweet_params)
    respond_to do |format|
      format.js {} if @tweet.save
    end
  end

  def destroy
    @tweet = current_user.tweets.find(params[:id])
    @tweet.destroy
    respond_to do |format|
      format.js {}
    end
  end

  def index
    @tweet = Tweet.new
    followers_tweets = Tweet.get_followers
    @tweets = Tweet.my_tweets + followers_tweets
    @replies = Tweet.get_replies(params[:id])
  end

  def reply
    @reply = current_user.tweets.new(parent_tweet_id: @tweet.id, body: params[:body], image: params[:image],
                                     tweet_type: :reply)
    respond_to do |format|
      format.js {} if @reply.save
    end
  end

  def retweet
    @retweet = current_user.tweets.new(parent_tweet_id: @tweet.id, tweet_type: :retweet)
    @retweet.body = @tweet.body.to_s
    @retweet.image = @tweet.image.blob
    respond_to do |format|
      format.js {} if @retweet.save
    end
  end

  def setup_tweet
    @tweet = Tweet.find(params[:id])
  end

  def show
    @replies = Tweet.get_replies(params[:id])
    @user = User.find(@tweet.user_id)
    Visitor.create(tweet_id: @tweet.id, user_id: current_user.id) if Visitor.where(tweet_id: @tweet.id,
                                                                                   user_id: current_user.id).blank?
  end

  def like
    @tweet = Tweet.find(params[:id])

    if current_user.already_liked?(@tweet)
      current_user.unlike(@tweet)
    else
      current_user.like(@tweet)
    end
    respond_to do |format|
      format.js { render 'likes/like.js' }
    end
  end

  def like_index
    @tweet = Tweet.find(params[:id])
    @likes = liked_by_users(@tweet)
  end

  def visitors
    @tweet = Tweet.find(params[:id])
    @visitors_are = tweet_visitors(@tweet)
    # binding.pry
  end

  def tweet_params
    params.require(:tweet).permit(:body, :parent_tweet_id, :image)
  end
end
