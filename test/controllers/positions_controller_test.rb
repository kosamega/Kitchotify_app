require 'test_helper'

class PositionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @album = albums(:album1)
    @playlist = playlists(:playlist1)
    @user = users(:user1)
    @relation1 = music_playlist_relations(:relation1)
    @relation2 = music_playlist_relations(:relation2)
  end

  test '有効なプレイリスト' do
    assert @playlist.valid?
  end

  test '並び替えが成功する' do
    log_in_as(@user)
    @relation1.position = 0
    patch playlist_position_path(@playlist), params: { drag: @relation1.position, drop: @relation2.position }
    @relation1.reload
    assert_equal 1, @relation1.position
  end
end
