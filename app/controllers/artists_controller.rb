class ArtistsController < ApplicationController
  before_action :logged_in_user
  before_action :set_artist, only: %i[ show edit update destroy ]

  def index
    @artists = Artist.all
  end

  def show
  end

  def new
    @artist = Artist.new
  end

  def edit
  end

  def create
    @artist = Artist.new(artist_params)
    if @artist.save
      flash[:success] = "#{@artist}を作成しました"
      redirect_to artist_path(@artist)
    else
      flash[:danger] = @artist.errors.full_messages.join('<br>')
      render 'new'
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

  # DELETE /artists/1 or /artists/1.json
  def destroy
    @artist.destroy

    respond_to do |format|
      format.html { redirect_to artists_url, notice: "Artist was successfully destroyed." }
      format.json { head :no_content }
    end
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
