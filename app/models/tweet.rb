# == Schema Information
#
# Table name: tweets
#
#  id              :integer          not null, primary key
#  body            :text
#  publish_at      :datetime
#  tweet_type      :string           default("tweet")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  parent_tweet_id :integer
#  user_id         :integer          not null
#
# Indexes
#
#  index_tweets_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Tweet < ActiveRecord::Base
  # include Likeable
  belongs_to :user # foreign key - employee_id
  has_many :likes, dependent: :destroy

  def liked_by?(user)
    likes.where(user:).any?
  end

  def add_visitor(current_user)
    Visitor.find_or_create_by(tweet_id: id, user_id: current_user.id)
  end

  has_many :visitors
  has_many :tweet_visitors, through: :visitors, source: :user

  belongs_to :parent_tweet, class_name: 'Tweet', foreign_key: :parent_tweet_id, optional: true

  validates :body, length: { maximum: 240 }, presence: true, unless: :parent_tweet_id

  has_one_attached :image

  has_many :retweets, -> { where tweet_type: 'retweet' }, class_name: 'Tweet', foreign_key: 'parent_tweet_id'

  has_many :replies, -> { where tweet_type: 'reply' }, class_name: 'Tweet', foreign_key: 'parent_tweet_id'

  scope :get_followers, -> { where(user_id: Current.user.followees).order(created_at: :desc) }
  scope :get_replies, ->(id) { where(parent_tweet_id: id).order(created_at: :desc) }
  scope :my_tweets, -> { where(user_id: Current.user).order(created_at: :desc) }

  # scope :tweet_visitors, ->(id) { Visitor.where(tweet_id: id) }
  # scope :list_likes, ->(id) { Like.where(tweet_id: id) }

  after_create_commit :notification

  def notification
    return if parent_tweet.nil? || parent_tweet.user == Current.user

    notification_reply_retweet = Notification.create(recipient: parent_tweet.user, actor: Current.user,
                                                     action: tweet_type, notifiable: self)

    NotificationJob.perform_later(parent_tweet, Current.user,
                                  notification_reply_retweet.action)
  end
end
