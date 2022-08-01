class ProfilesController < ApplicationController
  include ProfileHelper
  before_action :set_profile

  def show
  end

  def follow
    Relationship.create_or_find_by(follower_id: current_user.id, followee_id: @profile.id)
    respond_to do |format|
      format.js { }
    end
  end

  def unfollow
    current_user.followed_users.where(follower_id: current_user.id, followee_id: @profile.id).destroy_all
    respond_to do |format|
      format.js { }
    end
  end

  def follower
  end

  def set_profile
    @profile = User.find(params[:id])
  end
end
