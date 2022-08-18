class Tweet < ActiveRecord::Base
  include Likeable
  belongs_to :user
  belongs_to :parent_tweet, class_name: "Tweet", foreign_key: :parent_tweet_id, optional: true # optional true means that the tweet can be nil if the tweet is not a retweet
  has_many :comments, dependent: :destroy
  validates :body, length: { maximum: 240 }, allow_blank: false, unless: :parent_tweet_id
  has_one_attached :image

  def tweet_type
    if parent_tweet_id?
      "retweet"
    else
      "tweet"
    end
  end
end
