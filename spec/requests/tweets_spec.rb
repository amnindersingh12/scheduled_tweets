require 'rails_helper'

RSpec.describe 'Tweets', type: :request do
  # let!(:new_user) {FactoryBot.create(:user)}
  context 'Creating user' do
    it 'works! (now write some real specs)' do
      post '/users',
           params: { user: { first_name: 'user11', username: 'user11name', email: 'user@gmamil.com',
                             password: '11111111' } }
      # binding.pry
      # get tweets_path

      expect(response).to have_http_status(200)
    end
  end
end
