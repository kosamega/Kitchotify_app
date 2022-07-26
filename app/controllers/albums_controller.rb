class AlbumsController < ApplicationController
    def show
        @album = Album.find_by(id: params[:id])
        @musics = @album.musics
    end

end
