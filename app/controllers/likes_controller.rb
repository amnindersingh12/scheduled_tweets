class LikesController < ApplicationController
  before_action :set_likeable

  def create
    if @likeable.likes.count >= 1 && @likeable.liked_by?(current_user)
      @like = Like.find_by(likeable_id: @likeable.id, user: current_user)
      @like.destroy
      # Notification.create(recipient: @likeable.user, actor: current_user, action: 'unliked', notifiable: @likeable)
    else
      @like.user = current_user
      @like.save
      # Notification.create(recipient: @likeable.user, actor: current_user, action: 'liked', notifiable: @likeable)
    end
    respond_to do |format|
      format.js {}
    end
  end

  def index
    @likes = @likeable.likes
  end

  def set_likeable
    @likeable = params[:likeable_type].constantize.find(params[:likeable_id])
    @like = @likeable.likes.new
    @likes_count = @likeable.likes.count
  end
end
