json.album do
  json.name @album.name
  json.kiki_taikai_date @album.kiki_taikai_date
  json.url album_url(@album)
end
