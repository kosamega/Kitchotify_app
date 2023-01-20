class MusicsController < ApplicationController
  before_action :logged_in_user, only: %i[show edit update destroy]
  before_action :set_album
  before_action :set_music, only: %i[show edit update destroy]
  before_action :admin_user, only: %i[destroy]
  before_action :set_current_user_playlists, only: %i[show create]
  include MusicsHelper

  def show
    if @music.present?
      @same_artist_musics = @music.artist.musics
      @comments = @music.comments
      @musics = [@music]
      @infos = set_infos(@musics)
      gon.infos_j = @infos
      @music_show = true
    else
      render 'shared/not_found'
    end
  end

  def new
    @artists = Artist.all
    @artist = Artist.new
    @music = @album.musics.build
  end

  def edit
    @artists = Artist.all
  end

  def create
    if Artist.find_by(name: music_params[:artist_name]).nil?
      return respond_to do |format|
        format.html do
          flash.now[:danger] = "#{music_params[:artist_name]}というアーティストは存在しません。<br>ページ下部からアーティストを追加してください。"
          redirect_to new_album_music_path(@album)
        end
        format.js do
          @save = false
          @messages = "#{music_params[:artist_name]}というアーティストは存在しません。<br>ページ下部からアーティストを追加してください。"
        end
      end
    end

    @music = @album.musics.build(
      name: music_params[:name],
      track: music_params[:track],
      index_info: music_params[:index_info],
      artist_id: Artist.find_by(name: music_params[:artist_name]).id
    )
    if @music.save
      @messages = "以下の内容で曲を追加しました<br>曲名：#{@music.name}<br>アーティスト：#{@music.artist.name}<br>インデックス情報：<br>#{@music.index_info}"
      @number = params[:music][:track].to_i - 1
      @at_album_show = params[:at_album_show]
      @save = true
      flash.now[:success] = @messages
    else
      @messages = @music.errors.full_messages.join('<br>')
      @save = false
      flash.now[:danger] = @messages
    end
    @artists = Artist.all
    respond_to do |format|
      format.html { render 'new' }
      format.js
    end
  end

  def update
    @music.update(
      name: music_params[:name],
      track: music_params[:track],
      index_info: music_params[:index_info],
      artist_id: Artist.find_by(name: music_params[:artist_name]).id
    )
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
    @album = Album.find(params[:album_id])
  end

  def set_music
    @music = Music.find(params[:id])
  end

  def music_params
    params.require(:music).permit(:name, :artist_name, :track, :audio, :index_info)
  end
end
