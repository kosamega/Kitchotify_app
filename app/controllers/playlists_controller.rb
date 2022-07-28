class PlaylistsController < ApplicationController
  before_action :logged_in_user

  def create
    playlist = Playlist.new(user_id: current_user.id, name: params[:playlist][:name])
    playlist.save
    redirect_back_or "/"
  end

  def destroy
    Playlist.find_by(id: params[:id]).destroy
    redirect_to "/"
  end


  
  def show
    @playlist = Playlist.find_by(id: params[:id])
    @playlists = current_user.playlists
    @musics = @playlist.musics_included
  end

  end
