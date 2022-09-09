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
  let(:new_user) { FactoryBot.build(:user) }
  describe 'validations' do
    it 'must have email present' do
      new_user.email = nil
      expect(new_user).to_not be_valid
    end

    it 'must have password of length 6' do
      new_user.password = '11111111'
      expect(new_user.password.size).to be >= 6
    end
  end
end
