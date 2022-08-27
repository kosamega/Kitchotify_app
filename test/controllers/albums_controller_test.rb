require "test_helper"

class AlbumsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @album = albums(:g171)
  end 

  test "showが表示される" do
    get album_path(@album)
    assert_response :success
  end

  test "ログインしなければshowにアクセスできない" do
    get "/albums/1"
    assert_not flash.empty?
    assert_redirected_to "/login"
  end
end
