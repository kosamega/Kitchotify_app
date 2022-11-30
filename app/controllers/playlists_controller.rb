class PlaylistsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:update, :destroy, :sort]
  before_action :correct_user_or_public, only: [:show]
  before_action :not_kitchonkun, only: [:create, :update, :destroy]
  skip_before_action :verify_authenticity_token

  def create
    @playlist = current_user.playlists.build(playlist_params)
    @playlist.save
    respond_to do |format|
      format.html {redirect_back_or "/"}
      format.js
    end
  end

  def update
    @playlist = Playlist.find_by(id: params[:id])
    @playlist.update(playlist_params)
    respond_to do |format|
      format.html {redirect_back_or "/"}
      format.js
    end
  end

  def destroy
    Playlist.find_by(id: params[:id]).destroy
    redirect_to "/"
  end

  def index
    @playlists = Playlist.where(public: 1)
  end
  
  def show
    if @playlist = Playlist.find_by(id: params[:id])
      @at_playlist_show = true
      @playlists = current_user.playlists
      @relations = @playlist.music_playlist_relations.sort_by{ |a| a[:position] }
      @musics = @relations.map{|relation|relation.music}
      @infos = []
      require 'aws-sdk-s3'
      s3 = Aws::S3::Client.new
      signer = Aws::S3::Presigner.new(client: s3)
      @relations.each do |relation|
        url = signer.presigned_url(:get_object, 
                                    bucket: 'kitchotifyappstrage',
                                    key: "audio/#{relation.music.album.id}/#{relation.music.audio_path}",
                                    expires_in: 7200)
        @infos.push({url: url, name: relation.music.name, artist: relation.music.artist})
      end
      gon.infos_j = @infos
    else
      render "shared/not_found"
    end
  end

  def sort
    if !(params[:drag] == params[:drop])
      MusicPlaylistRelation.find_by(playlist_id: params[:id], position: params[:drag]).insert_at(params[:drop].to_i)
    end
  end

  private 
    def playlist_params
      params.require(:playlist).permit(:name, :public, :comment)
    end

    def correct_user_or_public
      if @playlist = Playlist.find_by(id: params[:id])
        unless (@playlist.user == current_user) || (@playlist.public == 1)
          redirect_to("/")
        end
      end
    end
  end
