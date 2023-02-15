class AlbumsController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user, only: %i[destroy]
  # before_action :released, only: %i[show]
  before_action :set_album, only: %i[show edit update destroy]
  before_action :set_current_user_playlists, only: %i[show]
  before_action :set_current_user_volume, only: %i[show]

  include MusicsHelper

  def index
    @albums = Album.includes(jacket_attachment: [blob: :variant_records])
  end

  def show
    @musics = @album.musics.includes(:artist, :likes, audio_attachment: :blob)
    @at_album_show = true
    @infos = set_infos(@musics)
    gon.infos_j = @infos
    @artists = Artist.all
  end

  def new; end

  def edit; end

  def create
    @album = Album.new(album_params)
    if @album.save
      flash[:success] = "#{@album.name}が追加されました"
      redirect_to @album
    else
      flash.now[:danger] = @album.errors.full_messages.join('<br>')
      render 'new'
    end
  end

  def update
    if @album.update(album_params)
      @album.update(editor_id: current_user.id)
      flash[:success] = 'アルバムを更新しました'
      redirect_to @album
    else
      flash.now[:danger] = @album.errors.full_messages.join('<br>')
      render 'edit'
    end
  end

  def destroy
    @album.destroy
    flash[:success] = 'アルバムを削除しました'
    redirect_to albums_path
  end

  private

  def set_album
    @album = Album.find(params[:id])
  end

  def album_params
    params.require(:album).permit(:name, :jacket, :kiki_taikai_date, :released)
  end

  def released
    unless Album.find_by(id: params[:id]).present? && !Album.find_by(id: params[:id]).released? && !current_user.admin?
      return
    end

    flash[:danger] = 'まだリリースされていません'
    redirect_to root_path
  end
end
