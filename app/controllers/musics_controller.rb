class MusicsController < ApplicationController
  before_action :logged_in_user
  before_action :set_album
  before_action :admin_user, only: %i[create destroy]
  include MusicsHelper

  def show
    if (@music = Music.find_by(id: params[:id]))
      @playlists = current_user.playlists
      @artistsmusics = Music.where(artist: @music.artist)
      @comments = @music.comments
      @infos = []
      @musics = [@music]
      set_infos(@musics)
      gon.infos_j = @infos
      @music_show = true
    else
      render 'shared/not_found'
    end
  end

  def edit
    @music = Music.find_by(id: params[:id])
  end

  def create
    @music = @album.musics.build(music_params)
    if @music.save
      @messages = '曲を追加しました'
      @number = params[:music][:track].to_i - 1
      @playlists = current_user.playlists
      @at_album_show = params[:at_album_show]
      @save = true
    else
      @messages = @music.errors.full_messages
      @save = false
    end
    respond_to do |format|
      format.html { redirect_back_or '/' }
      format.js
    end
  end

  def update
    @music = Music.find_by(id: params[:id])
    @music.update(music_params)
    if @music.errors.full_messages.present?
      flash[:danger] = @music.errors.full_messages
    else
      flash[:success] = '更新されました'
    end
    redirect_to [@album, @music]
  end

  def destroy
    @album.musics.find_by(id: params[:id]).destroy
    redirect_to album_path(@album)
  end

  private

  def set_album
    @album = Album.find_by(id: params[:album_id])
  end

  def music_params
    params.require(:music).permit(:name, :artist, :track, :audio, :index_info)
  end
end
