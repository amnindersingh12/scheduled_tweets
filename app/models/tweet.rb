class Tweet < ActiveRecord::Base
  belongs_to :user
  validates :body, length: { maximum: 240 }, allow_blank: false
end