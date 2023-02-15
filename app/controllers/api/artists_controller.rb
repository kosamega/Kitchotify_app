class Api::ArtistsController < Api::Base
  before_action :authenticate_search_api, only: %i[index]
  before_action :name_exist?

  def index
    @artists = Artist.where('UPPER(name) LIKE ?', "%#{params[:name].upcase}%").includes(musics: %i[album artist])
  end
end
