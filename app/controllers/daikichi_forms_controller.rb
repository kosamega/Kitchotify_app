class DaikichiFormsController < ApplicationController
  before_action :logged_in_user
  before_action :set_daikichi_form, only: %i[show edit update destroy]
  before_action :representative_user, only: %i[new create edit update destroy]
  before_action :set_current_user_playlists, only: %i[show]
  before_action :set_current_user_volume, only: %i[show]

  include MusicsHelper

  def index
    @daikichi_forms = DaikichiForm.all.sort_by(&:accept_until).reverse
  end

  def show
    @musics = @daikichi_form.musics_for_voting
    @infos = set_infos(@musics)
    gon.infos_j = @infos
  end

  def new
    @daikichi_form = DaikichiForm.new
  end

  def edit; end

  def create
    @daikichi_form = DaikichiForm.new(daikichi_form_params)
    if @daikichi_form.save
      flash[:success] = '投票フォームを作成しました'
      redirect_to daikichi_form_url(@daikichi_form)
    else
      render :new
    end
  end

  def update
    if @daikichi_form.update(daikichi_form_params)
      flash[:success] = "#{@daikichi_form.name}を更新しました"
      redirect_to daikichi_form_url(@daikichi_form)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @daikichi_form.destroy
    flash[:success] = "#{@daikichi_form.name}を削除しました"
    redirect_to daikichi_forms_url
  end

  private

  def set_daikichi_form
    @daikichi_form = DaikichiForm.find(params[:id])
  end

  def daikichi_form_params
    params.require(:daikichi_form).permit(:name, :three_point, :two_point, :one_point, :form_closed, :accept_until,
                                          :result_open, :description, music_ids_for_voting: [])
  end
end
