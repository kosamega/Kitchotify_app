class Api::AlbumsController < ApplicationController
  def index
    return render json: { errors: 'AccessKeyが間違っています' } if params[:AccessKey] != ENV.fetch('KITCHOTIFY_ACCESS_KEY')

    @albums = Album.where('UPPER(name) LIKE ?', "%#{params[:name].upcase}%").includes(musics: %i[artist album])
  end
end
