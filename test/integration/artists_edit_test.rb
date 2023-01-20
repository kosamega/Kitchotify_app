require "test_helper"

class ArtistsEditTest < ActionDispatch::IntegrationTest
  def setup
    @artist = artists(:artist1)
    @user = users(:user1)
    log_in_as(@user)
  end

  test 'artistの編集に失敗' do
    get edit_artist_path(@artist)
    assert_template 'artists/edit'
    patch artist_path(@artist), params: {artist: {name: ""}}
    assert_redirected_to edit_artist_path(@artist)
  end

  test 'artistの編集に成功' do
    get edit_artist_path(@artist)
    assert_template 'artists/edit'
    patch artist_path(@artist), params: {artist: {name: "new_artist"}}
    assert flash.any?
    assert_redirected_to artist_path(@artist)
    @artist.reload
    assert_equal "new_artist", @artist.name
  end
end
