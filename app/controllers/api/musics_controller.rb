class Api::MusicsController < Api::Base
  def index
    @musics = Music.where('UPPER(name) LIKE ?', "%#{params[:name].upcase}%").includes(:artist, :album)
  end
end
