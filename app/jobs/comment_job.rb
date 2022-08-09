class CommentJob < ApplicationJob
  queue_as :urgent

  def perform(comment, sender_author)
    # here, comment is the comment object, and sender_author is the user who commented
    CommentMailer.comment_email(sender_author, comment).deliver_later
  end


end
