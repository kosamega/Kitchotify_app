class DaikichiVotesController < ApplicationController
  before_action :logged_in_user
  before_action :set_daikichi_form
  before_action :set_daikichi_vote, only: %i[show edit update destroy]
  before_action :set_musics_for_voting, only: %i[new edit create update]
  before_action :not_voted_yet, only: %i[new create]

  def index
    @daikichi_votes = @daikichi_form.daikichi_votes
  end

  def show; end

  def new
    @daikichi_vote = DaikichiVote.new
  end

  def edit
  end

  def create
    @daikichi_vote = @daikichi_form.daikichi_votes.build(daikichi_vote_params)

    respond_to do |format|
      if @daikichi_vote.save
        format.html do
          redirect_to daikichi_form_daikichi_vote_url(@daikichi_form, @daikichi_vote),
                      notice: 'Daikichi vote was successfully created.'
        end
        format.json { render :show, status: :created, location: @daikichi_vote }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @daikichi_vote.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @daikichi_vote.update(daikichi_vote_params)
        format.html do
          redirect_to daikichi_form_daikichi_vote_url(@daikichi_form, @daikichi_vote),
                      notice: 'Daikichi vote was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @daikichi_vote }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @daikichi_vote.errors, status: :unprocessable_entity }
      end
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
    @musics_for_voting = @daikichi_form.musics_for_voting
  end

  def not_voted_yet
    return unless @daikichi_vote = @daikichi_form.daikichi_votes.find_by(user_id: current_user.id)
    flash[:danger] = '投票済みです'
    redirect_to edit_daikichi_form_daikichi_vote_path(@daikichi_form, @daikichi_vote)
  end

  def daikichi_vote_params
    params.require(:daikichi_vote).permit(:user_id, :daikichi_form_id, three_point_musics: [], two_point_musics: [],
                                                                       one_point_musics: [])
  end
end
