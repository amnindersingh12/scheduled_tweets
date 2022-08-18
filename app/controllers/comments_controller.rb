class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet

  def create
    # merge(user: current_user) is because i want to pass the user that is logged in to the comment object
    @comment = @tweet.comments.new(comment_params.merge(user: current_user))

    if @comment.save

      # Send email to user who commented
      sender_author = @comment.tweet.user # tweet.user is the author of the tweet that the comment is associated with (parent_tweet_id)
      if sender_author != @comment.user # comment.user is the user who commented

        # sending email to the user who commented
        CommentJob.set(wait: 5.seconds).perform_later(@comment, sender_author)
      end

      # Send email to all users who liked the tweet
      @comment.tweet.likes.uniq - [@comment.user].each do |like|
        CommentJob.set(wait: 5.seconds).perform_later(@comment, like)
      end
    end
    respond_to do |format|
      Notification.create(recipient: sender_author, actor: @comment.user, action: "commented", notifiable: @comment)
      format.js
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
    @tweet = Tweet.find(params[:parent_tweet_id])
  end
end
