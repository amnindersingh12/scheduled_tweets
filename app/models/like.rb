class Like < ApplicationRecord
  belongs_to :likeable, polymorphic: true
  belongs_to :user

  after_commit do
    # binding.pry
    NotificationJob.perform_later(likeable, likeable.user)
    puts 'neww'
    puts user.email
  end
end
