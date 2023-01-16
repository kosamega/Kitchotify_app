class MusicsController < ApplicationController
  before_action :logged_in_user, only: %i[show edit update destroy]
  before_action :set_album
  before_action :set_music
  before_action :admin_user, only: %i[destroy]
  include MusicsHelper

  def show
    if @music.present?
      @playlists = current_user.playlists
      @same_artist_musics = @music.artist.musics
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

  def new
    @artists = Artist.all
    @artist = Artist.new
  end

  def edit
    @artists = Artist.all
  end

  def create
    @music = @album.musics.build(music_params)
    if @music.save
      @messages = "以下の内容で曲を追加しました<br>曲名：#{@music.name}<br>アーティスト：#{@music.artist.name}<br>インデックス情報：<br>#{@music.index_info}"
      @number = params[:music][:track].to_i - 1
      @playlists = current_user&.playlists
      @at_album_show = params[:at_album_show]
      @save = true
      flash.now[:success] = @messages
    else
      @messages = @music.errors.full_messages.join('<br>')
      @save = false
      flash.now[:danger] = @messages
    end
    respond_to do |format|
      format.html { render 'new' }
      format.js
    end
  end

  def update
    @music.update(music_params)
    @muisc.update!(artist_id: Artist.find_by(name: music_params[:artist]).id)
    if @music.errors.full_messages.present?
      flash.now[:danger] = @music.errors.full_messages.join('<br>')
      render 'edit'
    else
      flash[:success] = '更新されました'
      redirect_to [@album, @music]
    end
  end

  def destroy
    @album.musics.find_by(id: params[:id]).destroy
    redirect_to album_path(@album)
  end

  private

  def set_album
    @album = Album.find_by(id: params[:album_id])
  end

  def set_music
    @music = Music.find_by(id: params[:id])
  end

  def music_params
    params.require(:music).permit(:name, :artist, :track, :audio, :index_info)
  end
end
