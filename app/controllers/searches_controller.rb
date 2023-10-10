class SearchesController < ApplicationController
  before_action :logged_in_user
  before_action :set_current_user_playlists, only: %i[index]
  before_action :set_current_user_volume, only: %i[index]
  include MusicsHelper

  def index
    @params = params[:search][:content].gsub(/^[[:blank:]]+|[[:blank:]]+$/, '')
    @musics = Music.where('UPPER(name) LIKE ?', "%#{@params.upcase}%").or(Music.where(artist_id: Artist.find_by(name: @params)&.id)).includes(
      { album: [jacket_attachment: [blob: :variant_records]] }, :artist, :likes, audio_attachment: :blob
    ).sort_by do |music|
      music.album.kiki_taikai_date
    end.reverse
    @users = User.where('UPPER(name) LIKE ?', "%#{@params.upcase}%")
    @result_playlists = Playlist.where('UPPER(name) LIKE ?', "%#{@params.upcase}%").where(public: true).includes(:user)
    @artists = Artist.where('UPPER(name) LIKE ?', "%#{@params.upcase}%")
    @designers = Designer.where('UPPER(name) LIKE ?', "%#{@params.upcase}%")
    @albums = Album.where('UPPER(name) LIKE ?', "%#{@params.upcase}%")
    @infos = set_infos(@musics)
    @show_user = true
    gon.infos_j = @infos
  end
end
