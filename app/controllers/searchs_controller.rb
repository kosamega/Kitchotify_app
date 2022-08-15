class SearchsController < ApplicationController
    before_action :logged_in_user
    def index
        @playlists = current_user.playlists
        @params = params[:search][:content]
        @result_musics = Music.where("name LIKE ?", "%#{@params}%").or(Music.where("artist LIKE?", "%#{@params}%"))
        @result_users = User.where("name LIKE ?", "%#{@params}%")
        @result_playlists = Playlist.where("name LIKE ?", "%#{@params}%")
    end
end
