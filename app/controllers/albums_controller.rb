class AlbumsController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user, only: %i[new create edit update destroy]
  before_action :released, only: %i[show]
  include MusicsHelper

  def index
    @albums = Album.all
  end

  def show
    if (@album = Album.find_by(id: params[:id]))
      @musics = @album.musics
      @playlists = current_user.playlists
      @at_album_show = true
      @infos = []
      set_infos(@musics)
      gon.infos_j = @infos
    else
      render 'shared/not_found'
    end
  end

  def new; end

  def edit
    @album = Album.find_by(id: params[:id])
  end

  def create
    @album = Album.create(album_params)
    redirect_to @album
  end

  def update
    @album = Album.find_by(id: params[:id])
    @album.update(album_params)
    @album.update(editor_id: current_user.id)
    redirect_to @album
  end

  def destroy
    Album.find_by(id: params[:id]).destroy
    redirect_to '/'
  end

  private

  def album_params
    params.require(:album).permit(:name, :jacket, :kiki_taikai_date, :released)
  end

  def released
    return unless Album.find_by(id: params[:id]).present? && !Album.find_by(id: params[:id]).released? && !current_user.admin?
    flash[:danger] = 'まだリリースされていません'
    redirect_to root_path
  end
end
