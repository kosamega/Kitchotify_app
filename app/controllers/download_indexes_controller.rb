class DownloadIndexesController < ApplicationController
  before_action :logged_in_user
  def create
    album = Album.find_by(id: params[:id])
    album.out_puts_index
    send_file "public/#{album.name}インデックス情報.txt"
  end
end
