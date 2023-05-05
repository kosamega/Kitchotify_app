require 'test_helper'

class AddMusicToPlaylistTest < ActionDispatch::IntegrationTest
  def setup
    @admin_user = users(:admin_user)
    @other_user = users(:not_admin_user)
    @playlist = playlists(:playlist1)
    @music = musics(:music1)
  end

  test '有効なプレイリスト' do
    assert @playlist.valid?
  end

  test '有効な曲' do
    assert @music.valid?
  end

  test '持ち主はプレイリストに曲を追加できる' do
    log_in_as(@admin_user)
    assert_difference 'MusicPlaylistRelation.count', 1 do
      post music_playlist_relations_path,
           params: { music_id: @music.id, playlist_id: @playlist.id, at_playlist_show: false }
    end
  end

  test '持ち主以外はプレイリストに曲を追加できない' do
    log_in_as(@other_user)
    assert_no_difference 'MusicPlaylistRelation.count' do
      post music_playlist_relations_path, params: { music_id: @music.id, playlist_id: @playlist.id }
    end
  end
end
