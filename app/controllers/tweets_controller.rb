class TweetsController < ApplicationController
  include ActionView::Helpers::DateHelper
  before_action :authenticate_user!
  before_action :setup_tweet, only: %i[retweet show reply like show_likes visitors]

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
    Visitor.find_or_create_by(tweet_id: @tweet.id, user_id: current_user.id) if current_user.id != @tweet.user.id
  end

  def like
    if current_user.already_liked?(@tweet)
      current_user.unlike(@tweet)
    else
      current_user.like(@tweet)
    end
    respond_to do |format|
      format.js {}
    end
  end

  def show_likes
    @likes = Tweet.list_likes(@tweet.id)
  end

  def visitors
    @visitors_are = Tweet.tweet_visitors(@tweet.id)
  end

  def tweet_params
    params.require(:tweet).permit(:body, :parent_tweet_id, :image)
  end
end
