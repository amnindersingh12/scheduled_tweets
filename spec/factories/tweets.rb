# == Schema Information
#
# Table name: tweets
#
#  id              :integer          not null, primary key
#  body            :text
#  publish_at      :datetime
#  tweet_type      :string           default("tweet")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  parent_tweet_id :integer
#  user_id         :integer          not null
#
# Indexes
#
#  index_tweets_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
FactoryBot.define do
  factory :tweet do
    sequence(:body) { |x| "Tweet ##{x}" }
  end
end
