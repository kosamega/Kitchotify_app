require 'test_helper'

class PlaylistTest < ActiveSupport::TestCase
  def setup
    @user = users(:kosamega)
    @playlist = @user.playlists.build(name: 'playlist1')
  end

  test 'ユーザーが有効' do
    assert @user.valid?
  end

  test 'プレイリストが有効' do
    assert @playlist.valid?
  end

  test '名前が空でない' do
    @playlist.name = '   '
    assert_not @playlist.valid?
  end

  test "user_idを持っている" do
    @playlist.user_id = nil
    assert_not @playlist.valid?
  end
end
