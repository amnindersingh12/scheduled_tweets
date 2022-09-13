# == Schema Information
#
# Table name: notifications
#
#  id              :integer          not null, primary key
#  action          :string
#  notifiable_type :string
#  read_at         :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  actor_id        :integer
#  notifiable_id   :integer
#  recipient_id    :integer
#
class Notification < ApplicationRecord
  belongs_to :actor, class_name: 'User'
  belongs_to :recipient, class_name: 'User'
  belongs_to :notifiable, polymorphic: true
  scope :find_recipient, ->(current_user) { where(recipient: current_user).order(created_at: :desc) }
  scope :unread, -> { where(read_at: nil) }
end
