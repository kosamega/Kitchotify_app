json.status 200
json.albums do
  json.array! @albums do |album|
    json.name album.name
    json.kiki_taikai_date album.kiki_taikai_date
    json.url album_url(album)
    json.musics do
      json.array! album.musics do |music|
        json.partial! 'api/musics/music', music:
      end
    end
  end
end
