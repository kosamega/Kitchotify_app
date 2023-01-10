class MusicListsController < ApplicationController
  before_action :logged_in_user
  def create
    album = Album.find_by(id: params[:album_id])
    send_data album.music_list, filename: "#{album.name}曲リスト.txt"
  end
end
