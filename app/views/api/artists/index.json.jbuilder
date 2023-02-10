json.status 200
json.artists do
  json.array! @artists do |artist|
    json.name artist.name
    json.bio artist.bio
    json.url artist_url(artist)
    json.musics do
      json.array! artist.musics do |music|
        json.partial! 'api/musics/music', music:
      end
    end
  end
end
