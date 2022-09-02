class Like < ApplicationRecord
  belongs_to :likeable, polymorphic: true
  belongs_to :user

  # def create
  #   @comment = @tweet.comments.new(comment_params.merge(user: current_user))
  #   if @comment.save
  #     sender_author = @comment.tweet.user
  #     CommentJob.set(wait: 5.seconds).perform_later(@comment, sender_author) if sender_author != @comment.user
  #     @comment.tweet.likes.uniq - [@comment.user].each do |like|
  #       CommentJob.set(wait: 5.seconds).perform_later(@comment, like)
  #     end
  #   end
  #   respond_to do |format|
  #     Notification.create(recipient: sender_author, actor: @comment.user, action: 'commented', notifiable: @comment)
  #     format.js
  #   end
  # end

  after_create_commit do
    if likeable.user != Current.user
      notification_like = Notification.create(recipient: likeable.user, actor: Current.user, action: 'liked',
                                              notifiable: likeable)

      NotificationJob.perform_later(likeable, likeable.user, notification_like.action)
    end
  end
end
