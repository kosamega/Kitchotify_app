json.musics do
  json.array! @musics do |music|
    json.partial! 'api/musics/music', music:
  end
end
