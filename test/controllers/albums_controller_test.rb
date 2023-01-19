require 'test_helper'

class AlbumsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @album = albums(:g171)
    @user = users(:user1)
  end

  test 'ログインすればshowが表示される' do
    log_in_as(@user)
    get album_path(@album)
    assert_response :success
  end

  test 'ログインしなければshowにアクセスできない' do
    get album_path(@album)
    assert_not flash.empty?
    assert_redirected_to new_sessions_path
  end
end
