class AlbumsController < ApplicationController
    before_action :logged_in_user
    def show
        if @album = Album.find_by(id: params[:id])
            @musics = @album.musics
            @playlists = current_user.playlists
        else
            render "shared/not_found"
        end
    end
end
