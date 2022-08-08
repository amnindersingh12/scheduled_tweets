class CommentJob < ApplicationJob
  queue_as :default

  def perform(comment, sender_author)
    CommentMailer.comment_email(comment, sender_author).deliver_later
  end


  def perform_later(comment, sender_author)
    CommentMailer.comment_email(comment, sender_author).deliver_later

  end

end
