require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:admin_user)
    @not_admin = users(:not_admin_user)
    @kitchonkun = users(:kitchonkun)
  end

  test 'ログインしなくてもnewにアクセスできる' do
    delete sessions_path
    get new_user_path
    assert_response :success
  end

  test 'サーバーのパスワードが正しいときuserを作成できる' do
    delete sessions_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: 'new_user1',
                                         password: 'password',
                                         password_confirmation: 'password' },
                                 auth: { kitchon_server_password: ENV.fetch('KITCHON_SERVER_PASSWORD', nil) } }
    end
    follow_redirect!
    assert_template 'static_pages/home'
  end

  test 'サーバーのパスワードが間違っているときuserを作成できない' do
    delete sessions_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: 'new_user1',
                                         password: 'password',
                                         password_confirmation: 'password' },
                                 auth: { kitchon_server_password: 'wrong' } }
    end
    assert_template 'users/new'
  end

  test '無効なユーザー登録は失敗する' do
    log_in_as(@admin)
    get new_user_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: '',
                                         password: 'foo',
                                         password_confirmation: 'bar' },
                                 auth: { kitchon_server_password: ENV.fetch('KITCHON_SERVER_PASSWORD', nil) } }
    end
    assert_template 'users/new'
  end

  test 'userを更新できる' do
    log_in_as(@not_admin)
    get edit_user_path(@not_admin)
    assert_template 'users/edit'
    name = 'updated_not_admin'
    patch user_path(@not_admin), params: { user: { name:, password: '', password_confirmation: '' } }
    assert_not flash.empty?
    assert_redirected_to @not_admin
    @not_admin.reload
    assert_equal name, @not_admin.name
  end

  test 'エディターモードのオンオフができる' do
    log_in_as(@not_admin)
    assert_not @not_admin.editor?
    patch user_path(@not_admin), params: { user: { editor: true } }
    @not_admin.reload
    assert @not_admin.editor?
  end
end
