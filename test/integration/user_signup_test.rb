require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:kosamega)
  end

  test '無効なユーザー登録は失敗する' do
    log_in_as(@user)
    get new_user_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: '',
                                         password: 'foo',
                                         password_confirmation: 'bar' } }
    end
    assert_template 'users/new'
  end

  test '有効なユーザー登録は成功する' do
    log_in_as(@user)
    get new_user_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: 'example',
                                         password: 'password',
                                         password_confirmation: 'password' } }
    end
    follow_redirect!
    assert_template 'users/show'
  end
end
