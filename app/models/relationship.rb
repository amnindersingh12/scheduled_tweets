class Relationship < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followee, class_name: 'User'

  # follower - arae the users who follows me
  # folowee - users whom im following
  after_create_commit do
    Notification.create(recipient: followee, actor: Current.user, action: 'followed', notifiable: followee)
  end
end


# a(follower) .  b .(followee)

# a -> .  b
