class ProfilesController < ApplicationController
  before_action :set_profile

  def show
  end

  def follow
    Relationship.create_or_find_by(follower_id: current_user.id, followee_id: @profile.id)
  end

  def unfollow
    current_user.followed_users.where(follower_id: current_user.id, followee_id: @profile.id).destroy_all
  end

  def set_profile
    @profile = User.find(params[:id])
  end
end
