class MusicsController < ApplicationController
  before_action :logged_in_user, only: %i[show edit update destroy]
  before_action :set_album
  before_action :set_music, only: %i[show edit update destroy]
  before_action :admin_user, only: %i[destroy]
  before_action :set_current_user_playlists, only: %i[show create]
  before_action :set_current_user_volume, only: %i[show]
  before_action :artist_exist?, only: %i[create]
  include MusicsHelper

  def show
    @same_artist_musics = @music.artist.musics.includes(album: [jacket_attachment: [blob: :variant_records]])
    @comments = @music.comments.includes(:user)
    @infos = set_infos([@music])
    gon.infos_j = @infos
    @music_show = true
    @description = ["アーティスト: #{@music.artist.name}", "アルバム: #{@album.name}",
                    "聴き大会: #{@album.kiki_taikai_date}"].compact.join(', ')
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
    return if Artist.find_by(id: music_params[:artist_id]).nil?

    @music = @album.musics.build(music_params)
    @music.audio.attach(music_params[:audio])
    if @music.save
      @messages = "以下の内容で曲を追加しました<br>曲名：#{@music.name}<br>アーティスト：#{@music.artist.name}<br>インデックス情報：<br>#{@music.index_info}"
      @number = params[:music][:track].to_i - 1
      @at_album_show = params[:at_album_show]
      @save = true
      @music.update(length: get_music_length(@music)) if @music.audio.attached?
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
    @music.update(music_params)
    @music.audio.attach(music_params[:audio]) if @music.audio.nil?
    @music.update(length: get_music_length(@music)) if @music.audio.attached?
    if @music.errors.full_messages.present?
      @save = false
      respond_to do |format|
        format.html do
          flash.now[:danger] = @music.errors.full_messages.join('<br>')
          render 'edit'
        end
        format.js
      end
    else
      @save = true
      respond_to do |format|
        format.html do
          flash[:success] = '更新されました'
          redirect_to [@album, @music]
        end
        format.js
      end
    end
  end

  def destroy
    @music.destroy
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
    params.require(:music).permit(:name, :artist_id, :track, :audio, :index_info, :daikichi_id, :d_track)
  end

  def artist_exist?
    return if (artist = Artist.find_by(id: music_params[:artist_id]))

    respond_to do |format|
      format.html do
        flash[:danger] = "#{artist&.name}というアーティストは存在しません。<br>ページ下部からアーティストを追加してください。"
        redirect_to new_album_music_path(@album)
      end
      format.js do
        @save = false
        @messages = "#{artist&.name}というアーティストは存在しません。<br>ページ下部からアーティストを追加してください。"
      end
    end
  end
end
