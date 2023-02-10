class Api::ArtistsController < Api::Base
  def index
    @artists = Artist.where('UPPER(name) LIKE ?', "%#{params[:name].upcase}%").includes(musics: %i[album artist])
  end
end
