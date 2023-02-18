require 'test_helper'

class AlbumsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @album = albums(:album1)
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

  test 'should get index' do
    get albums_path
    assert_not flash.empty?
    assert_redirected_to new_sessions_path
    log_in_as(@user)
    get album_path(@album)
    assert_response :success
  end

  test 'should get new' do
    get new_album_url
    assert_not flash.empty?
    assert_redirected_to new_sessions_path
    log_in_as(@user)
    get new_album_url
    assert_response :success
  end

  test 'should create album' do
    assert_no_difference('Album.count') do
      post albums_url, params: { album: { name: 'new_album', kiki_taikai_date: '2099-01-01' } }
    end
    log_in_as(@user)
    assert_difference('Album.count') do
      post albums_url, params: { album: { name: 'new_album', kiki_taikai_date: '2099-01-01' } }
    end
  end

  test 'should show album' do
    get album_path(@album)
    assert_not flash.empty?
    assert_redirected_to new_sessions_path
    log_in_as(@user)
    get album_path(@album)
    assert_response :success
  end

  test 'should get edit' do
    get edit_album_url(@album)
    assert_not flash.empty?
    assert_redirected_to new_sessions_path
    log_in_as(@user)
    get edit_album_url(@album)
    assert_response :success
  end

  test 'should update album' do
    log_in_as(@user)
    patch album_url(@album), params: { album: { name: 'update' } }
    @album.reload
    assert_equal 'update', @album.name
    assert_redirected_to album_url(@album)
  end

  test 'should destroy album' do
    assert_no_difference('Album.count') do
      delete album_url(@album)
    end
    log_in_as(@user)
    assert_difference('Album.count', -1) do
      delete album_url(@album)
    end

    assert_redirected_to albums_url
  end
end
