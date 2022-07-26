require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:kosamega)
  end 

  test "ログイン失敗" do
    get "/login"
    assert_template "sessions/new"
    post "/login", params: {session: {email: "", password: ""}}
    assert_not is_logged_in?
    assert_template "sessions/new"
    assert flash.any?
    get "/"
    assert flash.empty?
  end

  test "ログイン成功・ログアウト成功" do
    get "/login"
    assert_template "sessions/new"
    post "/login", params: {session: {email: @user.email,
                                       password: "password" }}
    assert is_logged_in?
    assert_redirected_to "/"
    follow_redirect!
    assert_template "static_pages/home"
    delete "/logout"
    assert_not is_logged_in?
    assert_redirected_to "/"
    follow_redirect!
    assert_template "static_pages/home"
  end
end
