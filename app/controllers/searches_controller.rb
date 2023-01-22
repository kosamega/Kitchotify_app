class SearchesController < ApplicationController
  before_action :logged_in_user
  before_action :set_current_user_playlists, only: %i[index]
  include MusicsHelper

  def index
    @params = params[:search][:content]
    @musics = Music.where('name LIKE ?', "%#{@params}%").or(Music.where(artist_id: Artist.find_by(name: @params)&.id)).includes(
      { album: [jacket_attachment: :blob] }, :artist, :likes, audio_attachment: :blob
    )
    @users = User.where('name LIKE ?', "%#{@params}%")
    @result_playlists = Playlist.where('name LIKE ?', "%#{@params}%").where(public: true).includes(:user)
    @artists = Artist.where('name LIKE ?', "%#{@params}%")
    @infos = set_infos(@musics)
    gon.infos_j = @infos
  end
end
