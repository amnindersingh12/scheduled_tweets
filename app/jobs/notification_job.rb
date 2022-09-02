class NotificationJob < ApplicationJob
  queue_as :default

  def perform(content, sender_author, action)
    # binding.pry
    if action == 'liked'
      NotificationMailer.send_like_notification(sender_author, content).deliver_later
    else
      NotificationMailer.send_notification(sender_author, content).deliver_later
    end
  end
end
