class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet

  def create
    # merge(user: current_user) is because i want to pass the user that is logged in to the comment object
    @comment = @tweet.comments.new(comment_params.merge(user: current_user))
    if @comment.save

      # Send email to user who commented
      sender_author = @comment.tweet.user # tweet.user is the author of the tweet that the comment is associated with (tweet_id)
      if sender_author != @comment.user # comment.user is the user who commented
        CommentMailer.comment_email(sender_author, @comment).deliver_now # Send email to author of tweet
      end

      # Send email to all users who liked the tweet
      @comment.tweet.likes.each do |like|
        if like.user != @comment.user
          CommentMailer.comment_email(like.user, @comment).deliver_now
        end
      end

      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    @comment = @tweet.comments.find(params[:id])
    respond_to do |format|
      @comment.destroy
      format.js { }
    end
  end


  def comment_params
    params.require(:comment).permit(:body, :image)
  end

  def set_tweet
    # tweet.id is the id of the tweet that the comment is associated with (tweet_id)
    @tweet = Tweet.find(params[:tweet_id])
  end
end
