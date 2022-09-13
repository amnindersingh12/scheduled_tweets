# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  password_digest        :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tweets, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :tweet

  def like(tweet)
    liked_tweets << tweet
  end

  def unlike(tweet)
    liked_tweets.destroy(tweet)
  end

  def already_liked?(tweet)
    liked_tweets.include? tweet
  end

  validates :email, presence: true, uniqueness: true
  has_one_attached :profile_image

  has_many :followed_users, foreign_key: :follower_id, class_name: 'Relationship', dependent: :destroy
  has_many :followees, through: :followed_users, dependent: :destroy

  has_many :following_users, foreign_key: :followee_id, class_name: 'Relationship', dependent: :destroy
  has_many :followers, through: :following_users, dependent: :destroy

  def create_follow(user)
    followed_users.create_or_find_by(followee_id: user)
  end

  def destroy_follow(user)
    followed_users.find_by(followee_id: user).destroy
  end

  def following?(user)
    followees&.include?(user)
  end


  has_many :notifications, foreign_key: :recipient_id
end
