class Relationship < ApplicationRecord
  # here we are saying that a relationship belongs to a user who is following another user
  belongs_to :follower, class_name: "User" # follower is the user who is following the other user
  belongs_to :followee, class_name: "User" # followee is the user who is being followed
end
