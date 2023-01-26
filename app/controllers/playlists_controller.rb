class PlaylistsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: %i[update destroy]
  before_action :correct_user_or_public, only: [:show]
  before_action :not_kitchonkun, only: %i[create update destroy]
  before_action :set_playlist, only: %i[show update destroy]
  before_action :set_current_user_playlists, only: %i[show]
  include MusicsHelper

  def index
    @playlists = Playlist.where(public: true).includes(:user)
  end

  def show
    @at_playlist_show = true
    @relations = @playlist.music_playlist_relations.sort_by { |a| a[:position] }
    @musics = @playlist.included_musics.includes(:artist, album: [jacket_attachment: :blob], audio_attachment: :blob)
    @infos = set_infos(@musics)
    gon.infos_j = @infos
    gon.playlist_id = @playlist.id
  end

  def create
    @playlist = current_user.playlists.build(playlist_params)
    @playlist.save
    respond_to do |format|
      format.html { redirect_back_or root_path }
      format.js
    end
  end

  def update
    @playlist.update(playlist_params)
    respond_to do |format|
      format.html { redirect_back_or root_path }
      format.js
    end
  end

  def destroy
    @playlist.destroy
    redirect_to root_path
  end

  private

  def playlist_params
    params.require(:playlist).permit(:name, :public, :comment)
  end

  def set_playlist
    @playlist = Playlist.find(params[:id])
  end

  def correct_user_or_public
    return unless (@playlist = Playlist.find_by(id: params[:id]))

    redirect_to root_path unless (@playlist.user == current_user) || @playlist.public?
  end
end
