require "test_helper"

class AlbumsControllerTest < ActionDispatch::IntegrationTest
  test "ログインしなければshowにアクセスできない" do
    get "/albums/1"
    assert_not flash.empty?
    assert_redirected_to "/login"
  end
end
