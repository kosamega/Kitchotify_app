class Api::ArtistsController < ApplicationController
  def index
    return render json: { errors: 'AccessKeyが間違っています' } if params[:AccessKey] != ENV.fetch('KITCHOTIFY_ACCESS_KEY')

    @artists = Artist.where('UPPER(name) LIKE ?', "%#{params[:name].upcase}%").includes(musics: %i[album artist])
  end
end
