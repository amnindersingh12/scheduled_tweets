class User < ApplicationRecord
    has_many :twitter_accounts, dependent: :destroy
    has_secure_password
    validates :email, presence: true, uniqueness: true,format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }

end