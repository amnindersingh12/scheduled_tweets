class TweetsController < ApplicationController
  include ActionView::Helpers::DateHelper

  before_action :authenticate_user!
  def index
    @tweet = Tweet.new
    followers_tweets = Tweet.get_followers

    @tweets = Tweet.my_tweets + followers_tweets
    # @tweets = Tweet.all.order(created_at: :desc)
    @replies = Tweet.get_replies(params[:id])
  end

  def create
    @tweet = current_user.tweets.new(tweet_params)
    respond_to do |format|
      if @tweet.save
        Notification.create(recipient: @tweet.user, actor: current_user, action: 'tweeted', notifiable: @tweet)
        format.js {}
      end
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
    @reply = Tweet.find(params[:id])
    @replies = Tweet.get_replies(params[:id])
    # where(parent_tweet_id: params[:id]).order(created_at: :desc)
    @user = User.find(@tweet.user_id)
  end

  def retweet
    @tweet = Tweet.find(params[:id])
    @retweet = current_user.tweets.new(parent_tweet_id: @tweet.id, tweet_type: :retweet)
    @retweet.body = @tweet.body.to_s
    @retweet.image = @tweet.image.blob
    respond_to do |format|
      if @retweet.save
        Notification.create(recipient: @tweet.user, actor: current_user, action: 'retweeted', notifiable: @retweet)
        format.js {}
      end
    end
  end

  def reply
    @tweet = Tweet.find(params[:id])
    @reply = current_user.tweets.new(parent_tweet_id: @tweet.id, body: params[:body], image: params[:image],
                                     tweet_type: :reply)
    respond_to do |format|
      format.js {} if @reply.save
    end
  end

  def destroy
    @tweet = current_user.tweets.find(params[:id])
    @tweet.destroy

    respond_to do |format|
      format.js {}
    end
  end

  def tweet_params
    params.require(:tweet).permit(:body, :parent_tweet_id, :image)
  end
end
