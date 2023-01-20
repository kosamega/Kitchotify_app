require 'test_helper'

class MusicsCreateTest < ActionDispatch::IntegrationTest
  def setup
    @album = albums(:album1)
    @artist = artists(:artist1)
  end

  test 'musicを作成できる' do
    get new_album_music_path(@album)
    assert_difference 'Music.count', 1 do
      post album_musics_path(@album), params: { music: { name: 'new_music',
                                                         artist_name: @artist.name } }
    end
    assert flash.any?
    assert_template 'musics/new'
  end

  test 'artistがいないときerrorメッセージが出る' do
    get new_album_music_path(@album)
    assert_no_difference 'Music.count' do
      post album_musics_path(@album), xhr: true, params: { music: { name: 'new_music',
                                                         artist_name: 'not_exist' } }
    end
    assert_template 'musics/create'
  end
end