class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tweets
  validates :email, presence: true, uniqueness: true
  has_one_attached :profile_image

  has_many :followed_users, foreign_key: :follower_id, class_name: 'Relationship', dependent: :destroy

  has_many :followees, through: :followed_users, dependent: :destroy

  has_many :following_users, foreign_key: :followee_id, class_name: 'Relationship', dependent: :destroy

  has_many :followers, through: :following_users, dependent: :destroy

  has_many :notifications, foreign_key: :recipient_id

  
end
