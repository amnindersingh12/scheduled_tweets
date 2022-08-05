class Comment < ApplicationRecord
  include Likeable
  belongs_to :user
  belongs_to :tweet
  has_many :comments , dependent: :destroy
  has_one_attached :image

end
