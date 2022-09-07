# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  password_digest        :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) do
    User.create(email: 'user1@gmail.com', password_digest: '11111111', username: 'user1',
                first_name: 'user_first')
  end

  describe '#email' do
    subject { user.email }
    context 'when a us5er have an email' do
      it 'returns the email ' do
        expect(subject).to eq('user1@gmail.com')
      end
    end
  end
end
