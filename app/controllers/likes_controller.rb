class LikesController < ApplicationController
  before_action :logged_in_user, :not_kitchonkun
  
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
    @playlists = current_user.playlists
  end
end
