class LikesController < ApplicationController
  before_action :set_likeable

  def create
    if @likeable.likes.count >= 1 && @likeable.liked_by?(current_user)
      @like = Like.find_by(likeable_id: @likeable.id, user: current_user)
      @like.destroy
    else
      @like = @likeable.likes.new
      @like.user = current_user
      @like.save
    end

    @likes_count = @likeable.likes.count
    respond_to do |format|
      format.js { }
    end
  end

  def set_likeable
    # end up being like a Tweet.find(params[:li....])
    @likeable = params[:likeable_type].constantize.find(params[:likeable_id])
  end
end
