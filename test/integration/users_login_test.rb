require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:kosamega)
  end

  test 'ログイン失敗' do
    get new_sessions_path
    assert_template 'sessions/new'
    post sessions_path, params: { session: { name: '', password: '' } }
    assert_not is_logged_in?
    assert_template 'sessions/new'
    assert flash.any?
  end

  test 'ログイン成功・ログアウト成功' do
    get new_sessions_path
    assert_template 'sessions/new'
    post sessions_path, params: { session: { name: @user.name,
                                             password: 'password' } }
    assert is_logged_in?
    assert_redirected_to '/'
    follow_redirect!
    assert_template 'static_pages/home'
    delete sessions_path
    assert_not is_logged_in?
    assert_redirected_to new_sessions_path
    follow_redirect!
    assert_template 'sessions/new'
  end
end
