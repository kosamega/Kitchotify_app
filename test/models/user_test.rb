require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'example', password: 'password', password_confirmation: 'password')
  end

  test '@userがvalid' do
    assert @user.valid?
  end

  test 'nameが存在' do
    @user.name = '  '
    assert_not @user.valid?
  end

  test 'nameが一意' do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'nameが50文字以下' do
    @user.name = 'a' * 51
    assert_not @user.valid?
  end

  test 'passwordが空でない' do
    @user.password = @user.password_confirmation = ' ' * 6
    assert_not @user.valid?
  end

  test 'passwordは8文字以上' do
    @user.password = @user.password_confirmation = 'a' * 7
    assert_not @user.valid?
  end
end
