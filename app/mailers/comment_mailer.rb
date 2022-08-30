class CommentMailer < ApplicationMailer
  def comment_email(user, comment)
    @user = user
    @comment = comment
    mail(
      to: user.email,
      from: "comment_#{@comment.id}@example.com",
      subject: 'You have a new comment on your tweet'
    )
  end
end
