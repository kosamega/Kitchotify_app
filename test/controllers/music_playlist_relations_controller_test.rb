require "test_helper"

class MusicPlaylistRelationsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:kosamega)
    @other_user = users(:posamega)
    @playlist = playlists(:one)
  end

  test "持ち主はプレイリストに曲を追加できる" do
    log_in_as(@user)
    assert_difference 'MusicPlaylistRelation.count', 1 do
      post music_playlist_relations_path, params: { music_id: 1, playlist_id: 1 }
    end
  end

  test "持ち主以外はプレイリストに曲を追加できない" do
    log_in_as(@other_user)
    assert_no_difference 'MusicPlaylistRelation.count' do
      post music_playlist_relations_path, params: { music_id: 1, playlist_id: 1 }
    end
  end
end
