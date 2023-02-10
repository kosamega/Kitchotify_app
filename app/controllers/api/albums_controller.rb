class Api::AlbumsController < Api::Base
  def index
    @albums = Album.where('UPPER(name) LIKE ?', "%#{params[:name].upcase}%").includes(musics: %i[artist album])
  end
end
