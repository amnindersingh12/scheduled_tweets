class Tweet < ActiveRecord::Base
  include Likeable
  belongs_to :user 
  has_many :comments , dependent: :destroy
  validates :body, length: { maximum: 240 }, allow_blank: false
end
