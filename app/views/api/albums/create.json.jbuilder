json.album do
  json.name @album.name
  json.kiki_taikai_date @album.kiki_taikai_date
  json.form_url new_album_music_url(@album)
end
