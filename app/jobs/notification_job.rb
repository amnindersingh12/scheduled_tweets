class NotificationJob < ApplicationJob
  queue_as :default

  def perform(content, sender_author)
    # binding.pry
    NotificationMailer.send_notification(sender_author, content).deliver_later
  end
end
