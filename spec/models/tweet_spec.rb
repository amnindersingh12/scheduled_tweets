require 'rails_helper'

RSpec.describe Tweet, type: :model do
  describe '#testing' do
    it 'should be true' do
      expect(1 + 2).to eq(3)
    end
  end

  describe '#validations' do
    it 'should have body' do
      tweet = Tweet.new(body: "").save
      expect(tweet).to eq(false)
    end
  end
end
