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
require 'rails_helper'

RSpec.describe Visitor, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
