class DaikichisController < ApplicationController
  before_action :logged_in_user
  before_action :set_daikichi_form
  before_action :set_results
  before_action :set_musics
  before_action :set_current_user_playlists, only: %i[show]
  before_action :set_current_user_volume, only: %i[show]

  include MusicsHelper

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(name: @daikichi_form.name.delete('投票'), kiki_taikai_date: @daikichi_form.accept_until)

    Album.transaction do
      if @album.save!
        params[:music_ids].each do |music_id|
          music = Music.find(music_id).dup
          music.save!
          music.update!(album_id: @album.id)
        end
        flash[:success] = "#{@album.name}を作成しました"
        redirect_to album_path(@album)
      else
        Rails.logger.debug @album.errors.full_messages
        render :new
      end
    end
  end

  private

  def set_daikichi_form
    @daikichi_form = DaikichiForm.find(params[:daikichi_form_id])
  end

  def set_results
    @results = @daikichi_form.results
  end

  def set_musics
    @musics = @results.map { |result| Music.find(result[:music_id]) }
  end
end
