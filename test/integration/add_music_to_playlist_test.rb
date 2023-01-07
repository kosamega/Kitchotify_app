require "test_helper"

class AddMusicToPlaylistTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:kosamega)
    @other_user = users(:posamega)
    @playlist = playlists(:one)
    @music = musics(:hikari)
  end

  test '有効なユーザー' do
    assert @user.valid?
  end

  test '有効なプレイリスト' do
    assert @playlist.valid?
  end

  test "有効な曲" do
    assert @music.valid?
  end

  test "持ち主はプレイリストに曲を追加できる" do
    log_in_as(@user)
    assert_difference 'MusicPlaylistRelation.count', 1 do
      post music_playlist_relations_path, params: { music_id: @music.id, playlist_id: @playlist.id, at_playlist_show: false  }
    end
  end

  test '持ち主以外はプレイリストに曲を追加できない' do
    log_in_as(@other_user)
    assert_no_difference 'MusicPlaylistRelation.count' do
      post music_playlist_relations_path, params: { music_id: 1, playlist_id: 1 }
    end
  end
end
