class IndicesController < ApplicationController
  before_action :logged_in_user
  def create
    album = Album.find_by(id: params[:album_id])
    send_data album.index_infos, filename: "#{album.name}インデックス情報.txt"
  end
end
