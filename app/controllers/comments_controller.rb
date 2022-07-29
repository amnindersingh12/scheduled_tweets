class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet

  def create
    @comment = @tweet.comments.new(comment_params.merge(user: current_user))
    respond_to do |format|
      @comment.save
      format.html { redirect_to @tweet, notice: "Commented!" }
    end
  end

  def destroy
    @comment = @tweet.comments.find(params[:id])
    respond_to do |format|
      @comment.destroy
      format.html { redirect_to @tweet, notice: "Comment Deleted!" }
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end
end
