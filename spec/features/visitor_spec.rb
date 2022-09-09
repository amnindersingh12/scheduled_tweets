require 'rails_helper'

RSpec.feature 'Visitors', type: :feature do
  let(:user1) { create(:user) }

  before do
    sign_in(user1)
  end

  feature 'current user visit tweets' do
    before do
      visit('/')
      expect(response).to have_http_status(200)
      fill_in 'reply_body', with: 'Test tweet'
      click_button 'Tweet'
    end
  end
end
def sign_in(user)
  visit '/users/sign_in'
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  click_button 'Log In'
  expect(page).to have_content 'Signed in successfully'
end
