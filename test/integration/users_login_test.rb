require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:kosamega)
  end

  test 'ログイン失敗' do
    get '/login'
    assert_template 'sessions/new'
    post '/login', params: { session: { name: '', password: '' } }
    assert_not is_logged_in?
    assert_template 'sessions/new'
    assert flash.any?
  end

  test 'ログイン成功・ログアウト成功' do
    get '/login'
    assert_template 'sessions/new'
    post '/login', params: { session: { name: @user.name,
                                        password: 'password' } }
    assert is_logged_in?
    assert_redirected_to '/'
    follow_redirect!
    assert_template 'static_pages/home'
    delete '/logout'
    assert_not is_logged_in?
    assert_redirected_to '/login'
    follow_redirect!
    assert_template 'sessions/new'
  end
end
