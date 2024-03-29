class AlbumsController < ApplicationController
  before_action :set_album, only: %i[show edit update destroy]
  before_action :set_tweet_info, only: %i[show]
  before_action :logged_in_user
  # before_action :released, only: %i[show]
  before_action :set_current_user_playlists, only: %i[show]
  before_action :set_current_user_volume, only: %i[show]

  include MusicsHelper

  def index
    @albums_released = Album.includes(jacket_attachment: [blob: :variant_records]).where(released: true)
    @albums_not_released = Album.includes(jacket_attachment: [blob: :variant_records]).where(released: false)
  end

  def show
    @musics = @album.musics.includes(:artist, :likes, audio_attachment: :blob)
    @at_album_show = true
    @infos = set_infos(@musics)
    gon.infos_j = @infos
    @artists = Artist.all
    @total_length = @album.musics.sum { |music| music.length || 0 }
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
    released = @album.released?
    if @album.update!(album_params)
      @album.update(editor_id: current_user.id)
      flash[:success] = 'アルバムを更新しました'
      @album.notify_new_release if released == false && @album.released?
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
    params.require(:album).permit(:name, :jacket, :kiki_taikai_date, :released, :designer_id)
  end

  def released
    unless Album.find_by(id: params[:id]).present? && !Album.find_by(id: params[:id]).released? && !current_user.role_admin?
      return
    end

    flash[:danger] = 'まだリリースされていません'
    redirect_to root_path
  end

  def set_tweet_info
    kiki_taikai_date = @album.kiki_taikai_date.present? ? "聴き大会: #{@album.kiki_taikai_date}" : nil
    designer_name = @album.designer.present? ? "ジャケットデザイン: #{@album.designer.name}" : nil
    description = [kiki_taikai_date, designer_name].compact.join(', ')
    title = @album.name
    img_url = @album.jacket&.url unless Rails.env.test?
    @twitter_info = { description:, title:, img_url: }
  end
end
