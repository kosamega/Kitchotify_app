require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @admin_user = users(:admin_user)
    @member_user = users(:member_user)
    @kitchonkun = users(:kitchonkun)
    @representative_user = users(:representative_user)
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
    log_in_as(@admin_user)
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
    log_in_as(@member_user)
    get edit_user_path(@member_user)
    assert_template 'users/edit'
    name = 'updated_member_user'
    patch user_path(@member_user), params: { user: { name:, password: '', password_confirmation: '' } }
    assert_not flash.empty?
    assert_redirected_to @member_user
    @member_user.reload
    assert_equal name, @member_user.name
  end

  test 'エディターモードのオンオフができる' do
    log_in_as(@member_user)
    assert_not @member_user.editor?
    patch user_path(@member_user), params: { user: { editor: true } }
    @member_user.reload
    assert @member_user.editor?
  end

  test 'adminとrepresentativeのみroleを変更できる' do
    log_in_as(@member_user)
    patch user_path(@member_user), params: { user: {name: 'member_user', role: 'admin'} }
    assert_redirected_to user_path(@member_user)
    @member_user.reload
    assert_not @member_user.role_admin?
    delete sessions_path
    log_in_as(@admin_user)
    patch user_path(@member_user), params: { user: {name: 'member_user', role: 'admin'} }
    assert_redirected_to user_path(@member_user)
    @member_user.reload
    assert @member_user.role_admin?
    delete sessions_path
    log_in_as(@representative_user)
    patch user_path(@member_user), params: { user: {name: 'member_user', role: 'representative'} }
    assert_redirected_to user_path(@member_user)
    @member_user.reload
    assert @member_user.role_representative?
  end
end
