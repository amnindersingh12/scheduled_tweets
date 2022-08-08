class TweetsController < ApplicationController
  include ActionView::Helpers::DateHelper # to use time_ago_in_words

  before_action :authenticate_user!

  def index
    @tweet = Tweet.new # to create a new tweet, @tweet is an instance of Tweet
    @tweets = Tweet.all.order(created_at: :desc)
  end

  def create
    @tweet = Tweet.new(tweet_params) #
    # @tweet is an instance of Tweet
    @tweet.user_id = current_user.id # user_id is the id of the user who created the tweet and user.id is the id of the user who created the tweet
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

  def retweet
    @tweet = Tweet.find(params[:id])
    @retweet = current_user.tweets.new(tweet_id: @tweet.id)
    @retweet.body = "#{@tweet.body}"
    @retweet.image = @tweet.image.blob
    respond_to do |format|
      if @retweet.save
        format.js { }
      end
    end
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    if current_user.id == Tweet.find(params[:id]).user_id # if the user who created the tweet is the same as the user who is deleting the tweet then delete the tweet
      @tweet.destroy
    end
    respond_to do |format|
      format.js { }
    end
  end

  def retweeters
    # list all the users who retweeted a tweet
    @retweeters = Tweet.all.select { |tweet| tweet.tweet_id != nil }
  end


  def tweet_params
    # here tweet_id is used to store the retweeted tweet id
    params.require(:tweet).permit(:body, :tweet_id, :image)
  end
end
