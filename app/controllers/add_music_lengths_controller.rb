class AddMusicLengthsController < ApplicationController
  include MusicsHelper
  def new
  end
  def create
    count = 0
    Music.all.each do |music|
      next if music.length.present? || !music.audio.attached?
      music.update(length: get_music_length(music))
      count += 1
    end
    flash[:success] = "#{count}個長さを追加しました"
    redirect_to new_add_music_length_path
  end
end
