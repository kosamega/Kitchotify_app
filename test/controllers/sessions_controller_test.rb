require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @album = albums(:album1)
    @admin_user = users(:admin_user)
  end

  test 'ログインしていない状態であるページにアクセスしたとき、ログインした後にそのページにリダイレクトされる' do
    get albums_path(@album)
    assert_redirected_to new_sessions_path
    log_in_as(@admin_user)
    assert_redirected_to albums_path(@album)
  end
end
