require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:user1)
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
    assert_not duplicate_user.valid?
  end
end
