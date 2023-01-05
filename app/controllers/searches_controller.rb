class SearchesController < ApplicationController
  before_action :logged_in_user
  include MusicsHelper

  def index
    @playlists = current_user.playlists
    @params = params[:search][:content]
    @musics = Music.where('name LIKE ?', "%#{@params}%").or(Music.where('artist LIKE?', "%#{@params}%"))
    @result_users = User.where('name LIKE ?', "%#{@params}%")
    @result_playlists = Playlist.where('name LIKE ?', "%#{@params}%").where(public: 1)
    @infos = []
    set_infos(@musics)
    gon.infos_j = @infos
  end
end
