module MusicsHelper
  def set_infos(musics)
    musics.each do |music|
      @infos.push({url: music.audio.url, name: music.name, artist: music.artist, index_info: music.index_info})
    end
  end
end
