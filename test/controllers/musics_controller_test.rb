require 'test_helper'

class MusicsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @album = albums(:album1)
    @admin_user = users(:admin_user)
    @artist = artists(:artist1)
    @music = musics(:music1)
    log_in_as(@admin_user)
  end

  test 'ログインしていなくてもmusicを作成できる' do
    delete sessions_path
    assert_difference('Music.count') do
      post album_musics_path(@album), params: { music: { name: 'hoge',
                                                         index_info: 'インデックス情報',
                                                         track: 0,
                                                         artist_id: @artist.id } }
    end
  end

  test 'should get new' do
    get new_album_music_path(@album)
    assert_response :success
  end

  test 'should show music' do
    get album_music_path(@album, @music)
    assert_response :success
  end

  test 'should get edit' do
    get edit_album_music_path(@album, @music)
    assert_response :success
  end

  test 'should destroy music' do
    assert_difference('Music.count', -1) do
      delete album_music_path(@album, @music)
    end

    assert_redirected_to album_path(@album)
  end
end
