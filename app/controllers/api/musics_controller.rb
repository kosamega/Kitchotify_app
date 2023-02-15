class Api::MusicsController < Api::Base
  before_action :name_exist?

  def index
    @musics = Music.where('UPPER(name) LIKE ?', "%#{params[:name].upcase}%").includes(:artist, :album)
  end
end
