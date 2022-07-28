class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet

  def create
    @comment = @tweet.comments.new(comment_params.merge(user: current_user))

    if @comment.save
      redirect_to tweets_path, notice: "Commented"
    else
      redirect_to tweet_path, alert: "Reply could not be created"
    end
  end

  def destroy
    @comment = @tweet.comments.find(params[:id])
    @comment.destroy
    redirect_to tweets_path, notice: "Comment Deleted!"
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end
end
