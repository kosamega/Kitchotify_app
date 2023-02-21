module MusicsHelper
  def set_infos(musics)
    musics.map.with_index do |music, index|
      { id: index, url: music.audio.url, name: music.name, artist: music.artist.name, index_info: music.index_info }
    end
  end
end
