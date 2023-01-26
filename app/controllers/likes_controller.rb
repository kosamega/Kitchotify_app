class LikesController < ApplicationController
  before_action :logged_in_user
  before_action :set_current_user_playlists, only: %i[index]
  before_action :set_current_user_volume, only: %i[index]
  before_action :set_like, only: %i[destroy]
  include MusicsHelper

  def index
    @musics = current_user.liked_musics.includes({ album: [jacket_attachment: :blob] }, [audio_attachment: :blob],
                                                 :artist, :likes)
    @like_index = true
    @infos = set_infos(@musics)
    gon.infos_j = @infos
  end

  def create
    @like = current_user.likes.create(music_id: params[:music_id])
    @number = params[:number]
    @like_id = "like#{params[:number]}"
    respond_to do |format|
      format.html { redirect_back_or root_path }
      format.js
    end
  end

  def destroy
    return unless @like.user == current_user

    @music = @like.music
    @number = params[:number]
    @like_id = "like#{params[:number]}"

    @unliked_music = @like.music
    @like.destroy
    @like_index = params[:like_index]
    respond_to do |format|
      format.html { redirect_back_or root_path }
      format.js
    end
  end

  def set_like
    @like = Like.find(params[:id])
  end
end
