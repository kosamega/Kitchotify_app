class DaikichiResultsController < ApplicationController
  before_action :logged_in_user
  before_action :set_daikichi_form, only: %i[show]
  before_action :set_current_user_playlists, only: %i[show]
  before_action :set_current_user_volume, only: %i[show]
  before_action :result_open, only: %i[show]

  include MusicsHelper

  def show
    votes = @daikichi_form.daikichi_votes
    @results =
      @daikichi_form.musics_for_voting.map do |music|
        three_point = votes.count { |vote| vote[:three_point_music_ids].include?(music.id.to_s) }
        two_point = votes.count { |vote| vote[:two_point_music_ids].include?(music.id.to_s) }
        one_point = votes.count { |vote| vote[:one_point_music_ids].include?(music.id.to_s) }
        total_point = (three_point * 3) + (two_point * 2) + one_point
        { music_id: music.id, three_point:, two_point:, one_point:,
          total_point:, length: music.length || 0 }
      end.sort_by { |result| result[:total_point] }.reverse
    total_length = 0
    @results.each do |result|
      result.store(:rank, @results.count { |r| r[:total_point] > result[:total_point] } + 1)
      result.store(:total_length, total_length += result[:length])
    end
    @musics = @results.map { |result| Music.find(result[:music_id]) }
    @infos = set_infos(@musics)
    gon.infos_j = @infos
  end

  private

  def set_daikichi_form
    @daikichi_form = DaikichiForm.find(params[:daikichi_form_id])
  end

  def result_open
    return if @daikichi_form.result_open? || current_user.admin?

    flash[:danger] = '投票結果はまだ公開されていません'
    redirect_to daikichi_forms_path
  end
end
