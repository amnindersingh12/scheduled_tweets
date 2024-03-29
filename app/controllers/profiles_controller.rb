class ProfilesController < ApplicationController
  before_action :set_profile

  def follow
    # Relationship.create_or_find_by(follower_id: current_user.id, followee_id: @profile.id)
    current_user.create_follow(@profile.id)

    respond_to do |format|
      format.html { redirect_back fallback_location: root_path }
      # Notification.create(recipient: @profile, actor: current_user, action: 'followed_you', notifiable: @profile)
      format.js {}
    end
  end

  def unfollow
    current_user.destroy_follow(@profile.id)

    # current_user.followed_users.where(follower_id: current_user.id, followee_id: @profile.id).destroy_all
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path }
      # Notification.create(recipient: @profile, actor: current_user, action: 'unfollowed_you', notifiable: @profile)
      format.js {}
    end
  end

  def follower
    @followers = @profile.followers
  end

  def set_profile
    @profile = User.find(params[:id])
  end
end
