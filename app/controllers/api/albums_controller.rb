class Api::AlbumsController < Api::Base
  before_action :authenticate_search_api, only: %i[index]
  before_action :name_exist?, only: %i[index]

  def index
    @albums = Album.where('UPPER(name) LIKE ?', "%#{params[:name].upcase}%").includes(musics: %i[artist album])
  end

  def create
    @album = Album.new(name: params[:name], kiki_taikai_date: params[:kiki_taikai_date])
    if @album.save
      @album
    else
      @messages = @album.errors.full_messages
      render 'api/shared/errors', status: :conflict
    end
  end
end
