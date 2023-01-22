class MusicPlaylistRelationsController < ApplicationController
  before_action :logged_in_user, :not_kitchonkun, :correct_user

  def create
    @music = Music.find(params[:music_id])
    @playlist = Playlist.find(params[:playlist_id])
    @playlist.add(@music)
    @at_playlist_show = params[:at_playlist_show]
    respond_to do |format|
      format.html { redirect_back_or '/' }
      format.js
    end
  end

  def destroy
    relation = MusicPlaylistRelation.find_by(music_id: params[:music_id], playlist_id: params[:playlist_id])
    @track_id = relation.position
    relation.destroy
    @playlist = Playlist.find(params[:playlist_id])
    @music = Music.find(params[:music_id])
    respond_to do |format|
      format.html { redirect_back_or '/' }
      format.js
    end
  end

  private

  def correct_user
    playlist_user = Playlist.find_by(id: params[:playlist_id]).user
    redirect_to('/') unless playlist_user == current_user
  end
end
