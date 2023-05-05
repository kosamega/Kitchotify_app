class DaikichiFormsController < ApplicationController
  before_action :logged_in_user
  before_action :set_daikichi_form, only: %i[show edit update destroy]
  before_action :admin_user, only: %i[new create edit update destroy]

  def index
    @daikichi_forms = DaikichiForm.all
  end

  def show
    return unless daikichi_vote = DaikichiVote.find_by(daikichi_form_id: @daikichi_form.id, user_id: current_user.id)
    @three_point_musics = daikichi_vote.three_point_musics.map{|music_id|Music.find(music_id)}
    @two_point_musics = daikichi_vote.two_point_musics.map{|music_id|Music.find(music_id)}
    @one_point_musics = daikichi_vote.one_point_musics.map{|music_id|Music.find(music_id)}
    @playlists = current_user.playlists
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
    params.require(:daikichi_form).permit(:name, :three_point, :two_point, :one_point, :form_closed, :accept_until, :result_open, albums_for_voting: [])
  end
end
