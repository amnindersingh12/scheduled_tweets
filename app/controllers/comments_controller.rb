class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet

  def create
    @comment = @tweet.comments.new(comment_params.merge(user: current_user))
    if @comment.save
      sender_author = @comment.tweet.user
      CommentJob.set(wait: 5.seconds).perform_later(@comment, sender_author) if sender_author != @comment.user
      @comment.tweet.likes.uniq - [@comment.user].each do |like|
        CommentJob.set(wait: 5.seconds).perform_later(@comment, like)
      end
    end
    respond_to do |format|
      Notification.create(recipient: sender_author, actor: @comment.user, action: 'commented', notifiable: @comment)
      format.js
    end
  end

  def destroy
    @comment = @tweet.comments.find(params[:id])
    respond_to do |format|
      @comment.destroy
      format.js {}
    end
  end

  def comment_params
    params.require(:comment).permit(:body, :image)
  end

  def set_tweet
    @tweet = Tweet.find(params[:parent_tweet_id])
  end
end
