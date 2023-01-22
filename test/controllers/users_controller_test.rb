require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:user1)
    @not_admin = users(:user2)
    @kitchonkun = users(:kitchonkun)
  end

  test 'adminかkitchonkunだけusers newにアクセス出来る' do
    log_in_as(@not_admin)
    get new_user_path
    assert_redirected_to '/'
    delete sessions_path
    log_in_as(@admin)
    get new_user_path
    assert_response :success
    delete sessions_path
    log_in_as(@kitchonkun)
    get new_user_path
    assert_response :success
  end

  test 'adminかkitchonkunだけusersを作成できる' do
    log_in_as(@not_admin)
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: 'fail',
                                         password: 'password',
                                         password_confirmation: 'password' } }
    end
    assert_redirected_to '/'
    log_in_as(@admin)
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: 'new_user1',
                                         password: 'password',
                                         password_confirmation: 'password' } }
    end
    follow_redirect!
    assert_template 'users/show'
    delete sessions_path
    log_in_as(@kitchonkun)
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: 'new_user2',
                                         password: 'password',
                                         password_confirmation: 'password' } }
    end
    follow_redirect!
    assert_template 'users/show'
  end

  test '無効なユーザー登録は失敗する' do
    log_in_as(@admin)
    get new_user_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: '',
                                         password: 'foo',
                                         password_confirmation: 'bar' } }
    end
    assert_template 'users/new'
  end
end
