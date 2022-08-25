class Tweet < ActiveRecord::Base
  include Likeable
  belongs_to :user
  belongs_to :parent_tweet, class_name: 'Tweet', foreign_key: :parent_tweet_id, optional: true
  validates :body, length: { maximum: 240 }, allow_blank: false, unless: :parent_tweet_id
  has_one_attached :image
  before_save :set_tweet_type

  def set_tweet_type
    self.tweet_type = if parent_tweet_id? && body?
                        'reply'
                      elsif !parent_tweet_id? && body?
                        'tweet'
                      elsif parent_tweet_id?
                        'retweet'
                      end
  end
end
