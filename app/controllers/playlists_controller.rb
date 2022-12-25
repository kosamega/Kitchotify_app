class PlaylistsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: %i[update destroy sort]
  before_action :correct_user_or_public, only: [:show]
  before_action :not_kitchonkun, only: %i[create update destroy]
  skip_before_action :verify_authenticity_token
  include MusicsHelper

  def index
    @playlists = Playlist.where(public: 1)
  end

  def show
    if (@playlist = Playlist.find_by(id: params[:id]))
      @at_playlist_show = true
      @playlists = current_user.playlists
      @relations = @playlist.music_playlist_relations.sort_by { |a| a[:position] }
      @musics = @relations.map(&:music)
      @infos = []
      set_infos(@musics)
      gon.infos_j = @infos
      gon.playlist_id = @playlist.id
    else
      render 'shared/not_found'
    end
  end

  def create
    @playlist = current_user.playlists.build(playlist_params)
    @playlist.save
    respond_to do |format|
      format.html { redirect_back_or '/' }
      format.js
    end
  end

  def update
    @playlist = Playlist.find_by(id: params[:id])
    @playlist.update(playlist_params)
    respond_to do |format|
      format.html { redirect_back_or '/' }
      format.js
    end
  end

  def destroy
    Playlist.find_by(id: params[:id]).destroy
    redirect_to '/'
  end

  def sort
    return unless params[:drag] != params[:drop]

    MusicPlaylistRelation.find_by(playlist_id: params[:id], position: params[:drag]).insert_at(params[:drop].to_i)
  end

  private

  def playlist_params
    params.require(:playlist).permit(:name, :public, :comment)
  end

  def correct_user_or_public
    return unless (@playlist = Playlist.find_by(id: params[:id]))

    redirect_to('/') unless (@playlist.user == current_user) || (@playlist.public == 1)
  end
end
