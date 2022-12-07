class LikesController < ApplicationController
  before_action :logged_in_user, :not_kitchonkun
  before_action :set_variables
  
  def create
    @like = current_user.likes.build(music_id: params[:music_id])
    @like.save
    @number = params[:number]
    respond_to do |format|
        format.html {redirect_back_or "/"}
        format.js
    end
  end

  def destroy
    @like = Like.find_by(id: params[:like_id])
    @music = @like.music
    @number = params[:number]
    if @like.user == current_user
      @unliked_music = @like.music
      @like.destroy
      @like_index = params[:like_index]
      respond_to do |format|
        format.html {redirect_back_or "/"}
        format.js
      end
    end
  end

  def index
    @likes = current_user.likes
    @musics = @likes.map{|like| like.music}
    @playlists = current_user.playlists
    @like_index = true
    @infos = []
    require 'aws-sdk-s3'
    s3 = Aws::S3::Client.new
    signer = Aws::S3::Presigner.new(client: s3)
    @likes.each do |like|
      url = signer.presigned_url(:get_object, 
                                  bucket: 'kitchotifyappstrage',
                                  key: "audio/#{like.music.album.id}/#{like.music.audio_path}",
                                  expires_in: 7200)
      @infos.push({url: url, name: like.music.name, artist: like.music.artist})
    end
    gon.infos_j = @infos
  end

  private
    def set_variables
      @track_id = params[:number]
      @like_id = "like#{params[:number]}"
    end
end
