class Tweet < ActiveRecord::Base
  include Likeable
  belongs_to :user  # foreign key - employee_id
  belongs_to :parent_tweet, class_name: 'Tweet', foreign_key: :parent_tweet_id, optional: true
  validates :body, length: { maximum: 240 }, allow_blank: false, unless: :parent_tweet_id
  has_one_attached :image

  scope :get_followers, -> { where(user_id: Current.user.followees).order(created_at: :desc) }
  scope :get_replies, ->(id) { where(parent_tweet_id: id).order(created_at: :desc) }
  scope :my_tweets, -> { where(user_id: Current.user).order(created_at: :desc) }
end
