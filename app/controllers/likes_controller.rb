class LikesController < ApplicationController
  before_action :logged_in_user, :not_kitchonkun
  before_action :set_variables
  
  def create
    @like = Like.new(user_id: params[:user_id], music_id: params[:music_id])
    @like.save
    respond_to do |format|
        format.html {redirect_back_or "/"}
        format.js
    end
  end

  def destroy
    @like = Like.find_by(id: params[:like_id])
    @unliked_music = @like.music
    @like.destroy
    @like_index = params[:like_index]
    respond_to do |format|
      format.html {redirect_back_or "/"}
      format.js
    end
  end

  def index
    @likes = current_user.likes
    @playlists = current_user.playlists
    @like_index = true
    @urls = []
    @music_names = []
    @music_artists = []
    require 'aws-sdk-s3'
    s3 = Aws::S3::Client.new
    signer = Aws::S3::Presigner.new(client: s3)
    @likes.each do |like|
      url = signer.presigned_url(:get_object, 
                                  bucket: 'kitchotifyappstrage',
                                  key: "audio/#{like.music.album.id}/#{like.music.audio_path}",
                                  expires_in: 7200)
      @urls.push(url)
      @music_names.push(like.music.name)
      @music_artists.push(like.music.artist)
    end
    @urls_j = @urls.to_json.html_safe
    @music_names_j = @music_names.to_json.html_safe
    @music_artists_j = @music_artists.to_json.html_safe
  end

  private
    def set_variables
      @id_name = ".like-form-#{params[:music_id]}"
      @like_id = ".like-form-#{params[:like_id]}"
    end
end
