require 'test_helper'

class ArtistsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @artist = artists(:artist1)
    @user1 = users(:user1)
    @user2 = users(:user2)
    log_in_as(@user1)
  end

  test 'should get index' do
    get artists_path
    assert_response :success
  end

  test 'should get new' do
    get new_artist_url
    assert_response :success
  end

  test 'should create artist' do
    assert_difference('Artist.count') do
      post artists_url, params: { artist: { name: 'hoge', user_id: @user1.id } }
    end
  end

  test 'should show artist' do
    get artist_path(@artist)
    assert_response :success
  end

  test 'should get edit' do
    get edit_artist_url(@artist)
    assert_response :success
  end

  test 'should update artist' do
    patch artist_url(@artist), params: { artist: { name: 'update', user_id: @user2.id } }
    assert_redirected_to artist_url(@artist)
  end

  test 'should destroy artist' do
    assert_difference('Artist.count', -1) do
      delete artist_url(@artist)
    end

    assert_redirected_to artists_url
  end
end
