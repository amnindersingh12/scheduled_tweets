class LikesController < ApplicationController
  before_action :set_likeable

  def create
    if @likeable.likes.count >= 1 && @likeable.liked_by?(current_user)
      @like = Like.find_by(likeable_id: @likeable.id, user: current_user)
      @like.destroy
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_path)}
        format.js
      end
    else
      @like = @likeable.likes.new
      @like.user = current_user
      @like.save
      respond_to do |format|
        format.html{ redirect_back(fallback_location: root_path)}
        format.js
      end
    end
  end

  private

  def set_likeable
    # end up being like a Tweet.find(params[:li....])
    @likeable = params[:likeable_type].constantize.find(params[:likeable_id])
  end
end
