class DaikichisController < ApplicationController
  before_action :logged_in_user
  before_action :set_daikichi, only: %i[show edit update destroy]
  before_action :set_current_user_playlists, only: %i[show]
  before_action :set_current_user_volume, only: %i[show]

  include MusicsHelper

  def index
    @daikichis = Daikichi.all
  end

  def show
    @musics = @daikichi.musics.order(:d_track).includes(:artist, :likes, audio_attachment: :blob)
    @infos = set_infos(@musics)
    gon.infos_j = @infos
    @artists = Artist.all
  end

  def new
    @daikichi = Daikichi.new
  end

  def edit; end

  def create
    @daikichi = Daikichi.new(daikichi_params)

    if @daikichi.save
      flash[:success] = "#{@daikichi.name}を作成しました"
      redirect_to daikichi_url(@daikichi)
    else
      render :new
    end
  end

  def update
    released = @daikichi.released?
    if @daikichi.update(daikichi_params)
      flash[:success] = "#{@daikichi.name}を更新しました"
      @daikichi.notify_new_release if released == false && @daikichi.released?
      redirect_to daikichi_url(@daikichi)
    else
      render :edit
    end
  end

  def destroy
    @daikichi.destroy
    flash[:success] = "#{@daikichi.name}を削除しました"

    redirect_to albums_path
  end

  private

  def set_daikichi
    @daikichi = Daikichi.find(params[:id])
  end

  def daikichi_params
    params.require(:daikichi).permit(:name, :released, :designer_id, :counting_votes_date, :jacket)
  end
end
