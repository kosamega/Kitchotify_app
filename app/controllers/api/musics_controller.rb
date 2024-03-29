class Api::MusicsController < Api::Base
  before_action :authenticate_search_api
  before_action :name_exist?, only: %i[index]

  def index
    @musics = Music.where('UPPER(name) LIKE ?', "%#{params[:name].upcase}%").includes(:artist, :album)
  end

  def random
    @random_music = params[:released] ? Music.released.offset(rand(Music.released.count)).first : Music.offset(rand(Music.count)).first
  end
end
