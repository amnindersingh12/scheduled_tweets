class Like < ApplicationRecord
  belongs_to :likeable, polymorphic: true # polymorphic association
  belongs_to :user # user who liked the tweet
end
