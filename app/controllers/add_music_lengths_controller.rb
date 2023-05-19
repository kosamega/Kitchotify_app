class AddMusicLengthsController < ApplicationController
  before_action :set_album

  include MusicsHelper

  def create
    count = 0
    @album.musics.each do |music|
      next if music.length.present? || !music.audio.attached?

      music.update(length: get_music_length(music))
      count += 1
    end
    flash[:success] = "#{count}個長さを追加しました"
    redirect_to album_path(@album)
  end

  def set_album
    @album = Album.find(params[:album_id])
  end
end
