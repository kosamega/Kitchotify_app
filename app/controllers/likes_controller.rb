class LikesController < ApplicationController
  def create
    @like = Like.new(user_id: current_user.id, music_id: params[:id])
    @like.save
    redirect_back_or "/"
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, music_id: params[:id])
    @like.destroy
    redirect_back_or "/"
  end

  def index
    @likes = current_user.likes
  end

end
