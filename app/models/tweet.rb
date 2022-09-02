class Tweet < ActiveRecord::Base
  include Likeable
  belongs_to :user  # foreign key - employee_id
  belongs_to :parent_tweet, class_name: 'Tweet', foreign_key: :parent_tweet_id, optional: true
  validates :body, length: { maximum: 240 }, allow_blank: false, unless: :parent_tweet_id
  has_one_attached :image
  has_many :retweets, -> { where(tweet_type: 'retweet') }, class_name: 'Tweet', foreign_key: 'parent_tweet_id'

  has_many :replies, -> { where(tweet_type: 'reply') }, class_name: 'Tweet', foreign_key: 'parent_tweet_id'

  scope :get_followers, -> { where(user_id: Current.user.followees).order(created_at: :desc) }
  scope :get_replies, ->(id) { where(parent_tweet_id: id).order(created_at: :desc) }
  scope :my_tweets, -> { where(user_id: Current.user).order(created_at: :desc) }

  after_create_commit :sending_notification_for_reply_retweet

  def sending_notification_for_reply_retweet
    return if parent_tweet.user == Current.user

    notification_reply_retweet = Notification.create(recipient: parent_tweet.user, actor: Current.user,
                                                     action: tweet_type, notifiable: self)

    NotificationJob.perform_later(parent_tweet, Current.user, notification_reply_retweet.action)
  end
end
