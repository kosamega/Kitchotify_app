class DaikichiVotesController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user, only: %i[index destroy]
  before_action :set_daikichi_form
  before_action :set_daikichi_vote, only: %i[show edit update destroy]
  before_action :correct_user, only: %i[show edit update]
  before_action :set_musics_for_voting, only: %i[new edit create update]
  before_action :not_voted_yet, only: %i[new create]
  before_action :form_clesed, only: %i[new edit create update]

  def index
    @daikichi_votes = @daikichi_form.daikichi_votes
  end

  def show
    @three_point_musics = @daikichi_vote.three_point_musics
    @two_point_musics = @daikichi_vote.two_point_musics
    @one_point_musics = @daikichi_vote.one_point_musics
    @playlists = current_user.playlists
  end

  def new
    @daikichi_vote = DaikichiVote.new
  end

  def edit; end

  def create
    @daikichi_vote = @daikichi_form.daikichi_votes.build(daikichi_vote_params)
    if daikichi_vote_params[:user_id] != current_user.id.to_s
      flash.now[:danger] = '不正なユーザーです'
      redirect_to daikichi_forms_path
      return
    end

    if @daikichi_vote.save
      flash[:success] = '投票が完了しました'
      redirect_to daikichi_form_daikichi_vote_path(@daikichi_form, @daikichi_vote)
    else
      render :new
    end
  end

  def update
    if @daikichi_vote.update(daikichi_vote_params)
      flash[:success] = '投票内容を更新しました'
      redirect_to daikichi_form_daikichi_vote_path(@daikichi_form, @daikichi_vote)
    else
      render :edit
    end
  end

  def destroy
    @daikichi_vote.destroy

    respond_to do |format|
      format.html do
        redirect_to daikichi_form_daikichi_votes_url(@daikichi_form),
                    notice: 'Daikichi vote was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  def set_daikichi_vote
    @daikichi_vote = DaikichiVote.find(params[:id])
  end

  def set_daikichi_form
    @daikichi_form = DaikichiForm.find(params[:daikichi_form_id])
  end

  def set_musics_for_voting
    @musics_for_voting = @daikichi_form.musics_for_voting.sort
  end

  def correct_user
    return if @daikichi_vote.user_id == current_user.id || current_user.admin?

    flash[:danger] = '不正なユーザーです'
    redirect_to daikichi_forms_path
  end

  def not_voted_yet
    return unless (@daikichi_vote = @daikichi_form.daikichi_votes.find_by(user_id: current_user.id))

    flash[:danger] = '投票済みです'
    redirect_to edit_daikichi_form_daikichi_vote_path(@daikichi_form, @daikichi_vote)
  end

  def form_clesed
    return if !@daikichi_form.form_closed? || current_user.admin?

    flash[:danger] = '投票期間は終了しました'
    redirect_to daikichi_forms_path
  end

  def daikichi_vote_params
    params.require(:daikichi_vote).permit(:user_id, :daikichi_form_id, three_point_music_ids: [], two_point_music_ids: [],
                                                                       one_point_music_ids: [])
  end
end
