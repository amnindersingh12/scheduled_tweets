class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet

  def create
    @comment = @tweet.comments.new(comment_params.merge(user: current_user))
    if @comment.save

      # Send email to user who commented
      sender_author = @comment.tweet.user
      if sender_author != @comment.user
        CommentMailer.comment_email(sender_author, @comment).deliver_now
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
  def recomment
    @comment = Comment.find(params[:id])
    @recomment = @comment.recomments.new(recomment_params.merge(user: current_user))
    @recomment.body = "#{@tweet.body}"
    @recomment.image = @tweet.image.blob
    if @recomment.save
      respond_to do |format|
        format.js { }
      end
    end
  end


  def comment_params
    params.require(:comment).permit(:body, :image)
  end

  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end
end
