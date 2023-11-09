class ArtistsController < ApplicationController
  before_action :logged_in_user, only: %i[index show new edit update destroy]
  before_action :admin_user, only: %i[destroy]
  before_action :set_artist, only: %i[show edit update destroy]
  before_action :set_current_user_playlists, only: %i[show]
  before_action :set_current_user_volume, only: %i[show]

  include MusicsHelper

  def index
    @artists = Artist.all
  end

  def show
    @musics = @artist.musics.includes([album: [jacket_attachment: [blob: :variant_records]]], :likes, :artist,
                                      audio_attachment: :blob)
    @infos = set_infos(@musics)
    gon.infos_j = @infos
  end

  def new
    @artist = Artist.new
  end

  def edit
    @users = User.all
  end

  def create
    @artist = Artist.new(artist_params)

    if @artist.save
      @save = true
      respond_to do |format|
        format.html do
          flash[:success] = "#{@artist.name}を作成しました"
          redirect_to artists_path
        end
        format.js
      end
    else
      @save = false
      respond_to do |format|
        format.html do
          flash.now[:danger] = @artist.errors.full_messages.join('<br>')
          render 'new'
        end
        format.js
      end
    end
  end

  def update
    if @artist.update(artist_params)
      flash[:success] = 'アーティスト情報を更新しました'
      redirect_to artist_path(@artist)
    else
      flash[:danger] = @artist.errors.full_messages.join('<br>')
      redirect_to edit_artist_path(@artist)
    end
  end

  def destroy
    @artist.destroy
    flash[:success] = "#{@artist.name}を削除しました"
    redirect_to artists_path
  end

  private

  def set_artist
    @artist = Artist.find(params[:id])
  end

  def artist_params
    params.require(:artist).permit(:name, :bio)
  end
end
