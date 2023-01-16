class ArtistsController < ApplicationController
  before_action :logged_in_user
  before_action :set_artist, only: %i[ show edit update destroy ]
  before_action :set_playlist

  def index
    @artists = Artist.all
  end

  def show
    @musics = @artist.musics
  end

  def new
    @artist = Artist.new
  end

  def edit
  end

  def create
    @artist = Artist.new(artist_params)
    if @artist.save
      @save = true
      flash[:success] = "#{@artist.name}を作成しました"
      respond_to do |format|
        format.html {redirect_to artists_path}
        format.js
      end
    else
      flash[:danger] = @artist.errors.full_messages.join('<br>')
      @save = false
      respond_to do |format|
        format.html {render 'new'}
        format.js
      end
    end
  end

  def update
    if @artist.update(artist_params)
      flash[:success] = "更新しました"
      redirect_to artist_path(@artist)
    else
      flash[:danger] = @artist.errors.full_messages.join('<br>')
    end
  end

  def destroy
    @artist.destroy
    redirect_to artists_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artist
      @artist = Artist.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def artist_params
      params.require(:artist).permit(:name, :user_id)
    end
end