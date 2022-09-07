class PlaylistsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:update, :destroy]
  before_action :correct_user_or_public, only: [:show]
  before_action :not_kitchonkun, only: [:create, :update, :destroy]

  def create
    playlist = current_user.playlists.build(playlist_params)
    playlist.save
    redirect_back_or "/"
  end

  def update
    Playlist.find_by(id: params[:id]).update(playlist_params)
    redirect_back_or "/"
  end

  def destroy
    Playlist.find_by(id: params[:id]).destroy
    redirect_to "/"
  end

  def index
    @playlists = Playlist.where(public: 1)
  end
  
  def show
    @playlist = Playlist.find_by(id: params[:id])
    @playlists = current_user.playlists
    @relations = @playlist.music_playlist_relations
  end

  private 
    def playlist_params
      params.require(:playlist).permit(:name, :public, :comment)
    end

    def correct_user_or_public
      @playlist = Playlist.find_by(id: params[:id])
      unless (@playlist.user == current_user) || (@playlist.public == 1)
        redirect_to("/")
      end
    end
  end
