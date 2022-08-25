class LikesController < ApplicationController
  before_action :set_likeable

  def create
    if @likeable.likes.count >= 1 && @likeable.liked_by?(current_user)
      @like = Like.find_by(likeable_id: @likeable.id, user: current_user)
      @like.destroy
      Notification.create(recipient: @likeable.user, actor: current_user, action: 'unliked', notifiable: @likeable)
    else
      @like = @likeable.likes.new
      @like.user = current_user
      @like.save
      Notification.create(recipient: @likeable.user, actor: current_user, action: 'liked', notifiable: @likeable)
    end
    @likes_count = @likeable.likes.count
    respond_to do |format|
      format.js {}
    end
  end

  def index
    @likes = @likeable.likes
  end

  def set_likeable
    @likeable = params[:likeable_type].constantize.find(params[:likeable_id])
  end
end
