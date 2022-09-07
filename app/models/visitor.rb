# == Schema Information
#
# Table name: visitors
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tweet_id   :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_visitors_on_tweet_id  (tweet_id)
#  index_visitors_on_user_id   (user_id)
#
# Foreign Keys
#
#  tweet_id  (tweet_id => tweets.id)
#  user_id   (user_id => users.id)
#
class Visitor < ApplicationRecord
  belongs_to :tweet
  belongs_to :user
end
