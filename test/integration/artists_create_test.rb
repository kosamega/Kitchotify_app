require 'test_helper'

class ArtistsCreateTest < ActionDispatch::IntegrationTest
  def setup
    @album = albums(:album1)
  end

  test 'musicsのnewでartistをajaxで正常に追加。データリストにartistが正常に追加。' do
    get new_album_music_path(@album)
    assert_select 'option[value=new_artist]', false
    assert_difference 'Artist.count', 1 do
      post artists_path, xhr: true, params: { artist: { name: 'new_artist' } }
    end
    assert_template 'artists/create'
    assert_select 'option[value=new_artist]'
  end
end
