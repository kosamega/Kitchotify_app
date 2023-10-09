class DaikichiResultsController < ApplicationController
  before_action :logged_in_user
  before_action :set_daikichi_form, only: %i[show]
  before_action :set_current_user_playlists, only: %i[show]
  before_action :set_current_user_volume, only: %i[show]
  before_action :result_open, only: %i[show]

  include MusicsHelper

  def show
    votes = @daikichi_form.daikichi_votes
    @results = @daikichi_form.results
    @musics = @results.map { |result| Music.find(result[:music_id]) }
    @infos = set_infos(@musics)
    gon.infos_j = @infos
  end

  private

  def set_daikichi_form
    @daikichi_form = DaikichiForm.find(params[:daikichi_form_id])
  end

  def result_open
    return if @daikichi_form.result_open? || current_user.role_is_a_producer?

    flash[:danger] = '投票結果はまだ公開されていません'
    redirect_to daikichi_forms_path
  end
end
