require 'test_helper'

class ArtistsCreateTest < ActionDispatch::IntegrationTest
  def setup
    @album = albums(:album1)
  end

  test 'musicsのnewでartistをajaxで正常に追加。selectにartistが正常に追加。' do
    get new_album_music_path(@album)
    assert_difference 'Artist.count', 1 do
      post artists_path, xhr: true, params: { artist: { name: 'new_artist' } }
    end
    assert_template 'artists/create'
    new_artist = Artist.find_by(name: 'new_artist')
    assert_select "option[value=#{new_artist.id}]"
  end
end
