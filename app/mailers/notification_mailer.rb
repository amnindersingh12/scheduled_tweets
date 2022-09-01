class NotificationMailer < ApplicationMailer
  def send_notification(user, content)
    @user = user
    @content = content
    mail(
      to: user.email,
      from: "notification_#{@content.id}@example.com",
      subject: 'You have a new notification on your tweet'
    )
  end
end
