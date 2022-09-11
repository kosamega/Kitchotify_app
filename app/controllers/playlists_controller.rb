class PlaylistsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:update, :destroy]
  before_action :correct_user_or_public, only: [:show]
  before_action :not_kitchonkun, only: [:create, :update, :destroy]

  def create
    playlist = current_user.playlists.build(playlist_params)
    playlist.save
    respond_to do |format|
      format.html {redirect_back_or "/"}
      format.js
  end
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
    if @playlist = Playlist.find_by(id: params[:id])
      @playlists = current_user.playlists
      @relations = @playlist.music_playlist_relations
      @urls = []
      @music_names = []
      @music_artists = []
      require 'aws-sdk-s3'
      s3 = Aws::S3::Client.new
      signer = Aws::S3::Presigner.new(client: s3)
      @relations.each do |relation|
        url = signer.presigned_url(:get_object, 
                                    bucket: 'kitchotifyappstrage',
                                    key: "audio/#{relation.music.album.id}/#{relation.music.audio_path}",
                                    expires_in: 1200)
        @urls.push(url)
        @music_names.push(relation.music.name)
        @music_artists.push(relation.music.artist)
      end
      @urls_j = @urls.to_json.html_safe
      @music_names_j = @music_names.to_json.html_safe
      @music_artists_j = @music_artists.to_json.html_safe
    else
      render "shared/not_found"
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
