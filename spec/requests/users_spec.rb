require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'Creating User' do
    it 'works! (now write some real specs)' do
      post '/users',
           params: { user: { first_name: 'user11', username: 'user11name', email: 'user@gmamil.com',
                             password: '11111111' } }

      # get users_path
      expect(response).to have_http_status(200)
    end
  end
end
