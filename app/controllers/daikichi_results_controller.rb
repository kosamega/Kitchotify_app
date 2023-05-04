class DaikichiResultsController < ApplicationController
  before_action :logged_in_user
  before_action :set_daikichi_form, only: %i[show]
  before_action :set_current_user_playlists, only: %i[show]
  before_action :set_current_user_volume, only: %i[show]

  include MusicsHelper

  def show
    votes = @daikichi_form.daikichi_votes
    @results =
      @daikichi_form.musics_for_voting.map do |music|
        three_point = votes.count{|vote| vote[:three_point_musics].include?(music.id.to_s)}
        two_point = votes.count{|vote| vote[:two_point_musics].include?(music.id.to_s)}
        one_point = votes.count{|vote| vote[:one_point_musics].include?(music.id.to_s)}
        total_point = three_point*3 + two_point*2 + one_point
        {music_id: music.id, three_point: three_point, two_point: two_point, one_point: one_point, total_point: total_point}
      end.sort_by{|result|result[:total_point]}.reverse
    @musics = @daikichi_form.musics_for_voting.sort_by{|music|@results.find{|result|result[:music_id] == music.id}[:total_point]}.reverse.includes(:artist, :likes, audio_attachment: :blob)
    @infos = set_infos(@musics)
    gon.infos_j = @infos
  end
  
  
  private

  def set_daikichi_form
    @daikichi_form = DaikichiForm.find(params[:daikichi_form_id])
  end  
end
