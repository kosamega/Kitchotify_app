class Api::MusicsController < ApplicationController
  def index
    return render json: { errors: 'AccessKeyが間違っています' } if params[:AccessKey] != ENV.fetch('KITCHOTIFY_ACCESS_KEY')

    @musics = Music.where('UPPER(name) LIKE ?', "%#{params[:name].upcase}%").includes(:artist, :album)
  end
end
