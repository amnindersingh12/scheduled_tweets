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
require 'rails_helper'

RSpec.describe Tweet, type: :model do
  let(:tweet) { Tweet.create(body: 'Something New') }

  describe '#body' do
    subject { tweet.body }

    context 'when a tweet have a body' do
      it 'returns the tweet body' do
        expect(subject).to eq('Something New')
      end
    end
  end

  describe '#testing' do
    it 'should be true' do
      expect(1 + 2).to eq(3)
    end
  end
end
