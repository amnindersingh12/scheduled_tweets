class ProfilesController < ApplicationController
  include ProfileHelper
  before_action :set_profile

  def show
  end

  def follow
    Relationship.create_or_find_by(follower_id: current_user.id, followee_id: @profile.id) # create_or_find_by is a method from the relationship model, which checks if the relationship already exists and if it does, it doesn't create a new one.

    respond_to do |format|
      Notification.create(recipient: @profile, actor: current_user, action: "followed_you", notifiable: @profile) # create a notification for the user who is being followed.
      format.js { }
    end
  end

  def unfollow

    current_user.followed_users.where(follower_id: current_user.id, followee_id: @profile.id).destroy_all
    respond_to do |format|
      Notification.create(recipient: @profile, actor: current_user, action: "unfollowed_you", notifiable: @profile) # create a notification for the user who is being unfollowed.
      format.js { }
    end
  end

  def follower
    @followers = @profile.followers # @followers is an array of users who are following @profile, here @profile is the user whose profile we are on.
  end

  def set_profile
    @profile = User.find(params[:id])
  end
end
