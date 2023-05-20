require 'test_helper'

class PlaylistsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @admin_user = users(:admin_user)
    @member_user = users(:member_user)
    @playlist1 = playlists(:playlist1)
    log_in_as(@admin_user)
  end

  test 'プレイリスト一覧' do
    get playlists_path
    assert_response :success
  end

  test 'プレイリストを新規作成できる' do
    assert_difference('Playlist.count') do
      post playlists_url, params: { playlist: { name: 'hoge', public: true, description: 'aaa' } }
    end
  end

  test 'プレイリストshow' do
    get playlist_path(@playlist1)
    assert_response :success
  end

  test 'プレイリストをアップデートできる' do
    patch playlist_path(@playlist1),
          params: { playlist: { name: 'hoge', public: true, description: 'new description' } }
    @playlist1.reload
    assert_equal 'new description', @playlist1.description
  end

  test 'プレイリストを削除できる' do
    assert_difference('Playlist.count', -1) do
      delete playlist_url(@playlist1)
    end
  end
end
