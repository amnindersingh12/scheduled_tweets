class Notification < ApplicationRecord
  belongs_to :actor, class_name: 'User'
  belongs_to :recipient, class_name: 'User'
  belongs_to :notifiable, polymorphic: true

  # to check if the notification is read or not
  scope :unread, -> { where(read_at: nil) }
end
