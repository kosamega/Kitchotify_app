class MusicPlaylistRelationsController < ApplicationController
  before_action :set_music_playlist_relation, only: %i[destroy]
  before_action :logged_in_user, :not_kitchonkun, :correct_user
  protect_from_forgery with: :null_session

  def create
    @music = Music.find(params[:music_id])
    @playlist = Playlist.find(params[:playlist_id])
    @playlist.add(@music)
    @at_playlists_show = params[:at_playlist_show]
    respond_to do |format|
      format.html { redirect_back_or root_path }
      format.js
    end
  end

  def destroy
    @music_playlist_relation.destroy
    @playlist = @music_playlist_relation.playlist
    @music = @music_playlist_relation.music
    respond_to do |format|
      format.js
    end
  end

  private

  def set_music_playlist_relation
    @music_playlist_relation = MusicPlaylistRelation.find(params[:id])
  end

  def correct_user
    playlist_user = @music_playlist_relation&.playlist&.user || Playlist.find(params[:playlist_id]).user
    redirect_to root_path unless playlist_user == current_user
  end
end
