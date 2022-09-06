# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tweet_id   :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_likes_on_tweet_id  (tweet_id)
#  index_likes_on_user_id   (user_id)
#
# Foreign Keys
#
#  tweet_id  (tweet_id => tweets.id)
#  user_id   (user_id => users.id)
#
class Like < ApplicationRecord
  belongs_to :tweet
  belongs_to :user

  after_save_commit do
    # binding.pry
    if tweet.user != Current.user
      notification_like = Notification.create(recipient: tweet.user, actor: Current.user, action: 'liked',
                                              notifiable: tweet)

      NotificationJob.perform_later(tweet, tweet.user, notification_like.action)
    end
  end

  after_destroy_commit do
    Notification.where(action: 'liked')
                .where(notifiable_id: tweet.id)
                .where(actor: Current.user).delete_all
  end
end
