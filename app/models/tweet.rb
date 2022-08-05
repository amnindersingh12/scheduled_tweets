class Tweet < ActiveRecord::Base
  include Likeable
  belongs_to :user
  belongs_to :tweet, optional: true
  has_many :comments , dependent: :destroy
  validates :body, length: { maximum: 240 },allow_blank: false, unless: :tweet_id
  has_one_attached :image

  def tweet_type
    if tweet_id?
      "retweet"
    else
      "tweet"
    end
  end
end

