# == Schema Information
#
# Table name: relationships
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  followee_id :integer
#  follower_id :integer
#
class Relationship < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followee, class_name: 'User'

  # follower - arae the users who follows me
  # folowee - users whom im following
  after_create_commit do
    Notification.create(recipient: followee, actor: Current.user, action: 'followed', notifiable: followee)
  end
end

# a(follower) .  b .(followee)

# a -> .  b
# a = 4
# b = 3
# id followerid followee id
#     4 .          3
# first_user = User.find_by(id: 2)
# first_user.follower
# select *  from users

# i need users
# student

# stid, name,
# 1 .    user1
# 2 .     user2

# subject
# subjid subj
# 1 .     math
# 2.      science

# realation
# userid subjid
# 1 .      1
# 1.       2
# 2 .      1

# find all subj of user 1
# select subject.subj from subject,realtion inner join on userid == 2
# select * from users join
