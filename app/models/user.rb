class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tweets
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  has_one_attached :profile_image
  validates :profile_image, presence: true

  # people we are following
  has_many :followed_users, foreign_key: :follower_id, class_name: "Relationship", dependent: :destroy

  has_many :followees, through: :followed_users, dependent: :destroy

  # people who are following us
  has_many :following_users, foreign_key: :followee_id, class_name: "Relationship", dependent: :destroy

  has_many :followers, through: :following_users, dependent: :destroy
end
