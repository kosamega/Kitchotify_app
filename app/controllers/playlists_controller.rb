class PlaylistsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:destroy]

  def create
    playlist = current_user.playlists.build(playlist_params)
    playlist.save
    redirect_back_or "/"
  end

  def destroy
    Playlist.find_by(id: params[:id]).destroy
    redirect_to "/"
  end

  def index
    @playlists = Playlist.all
  end
  
  def show
    @playlist = Playlist.find_by(id: params[:id])
    @playlists = current_user.playlists
    @musics = @playlist.musics_included
  end

  private 
    def playlist_params
      params.require(:playlist).permit(:name, :public, :comment)
    end

  end
